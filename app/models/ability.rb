class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?

    can :vote, Movie do |movie|
      movie.user_id != user.id
    end

    can :user, User do |u|
      user.uid == u.uid
    end

    can :create, Movie
  end
end
