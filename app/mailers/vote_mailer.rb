class VoteMailer < ActionMailer::Base
  def call(user:, movie:, like_or_hate:)
    prefix  = _prefix(like_or_hate)
    subject = I18n.t(prefix + '.subject')
    body    = I18n.t(prefix + '.body', user: user.name, movie: movie.title)

    mail(to: user.email, subject: subject, body: body)
  end

  private

  def _prefix(like_or_hate)
    ['mailers', 'vote', _key(like_or_hate)].join('.')
  end

  def _key(like_or_hate)
    case like_or_hate
    when :like then 'like'
    when :hate then 'hate'
    else raise
    end
  end
end
