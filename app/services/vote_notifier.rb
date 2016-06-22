# Send notification when move is voted on
class VoteNotifier
  def initialize(user, movie, mailer = VoteMailer)
    @user   = user
    @movie  = movie
    @mailer = mailer
  end

  def notify(like_or_hate)
    return false if same_user?
    return false unless wants_notifications?

    @mailer.call(user: @movie.user, movie: @movie, like_or_hate: like_or_hate)
  end

  private

  def wants_notifications?
    UserDecorator.new(@movie.user).wants_notifications?
  end

  def same_user?
    @user.uid == @movie.user.uid
  end
end
