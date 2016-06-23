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
    return false unless has_email?

    @mailer.call(user: @movie.user, movie: @movie, like_or_hate: like_or_hate).deliver!
    true
  rescue => e
    Rails.logger.warn e.message
    false
  end

  private

  def has_email?
    _user.has_email?
  end

  def wants_notifications?
    _user.wants_notifications?
  end

  def same_user?
    @user.uid == @movie.user.uid
  end

  def _user
    @_user ||= UserDecorator.new(@movie.user)
  end
end
