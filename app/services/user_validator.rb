class UserValidator
  def self.instance
    User
  end

  def initialize(user)
    @user   = user
    @errors = nil
  end

  def valid?
    errors.empty?
  end

  def errors
    return @errors if @errors
    @errors = {}

    unless [TrueClass, FalseClass].include?(@user.wants_notifications.class)
      @errors[:wants_notifications] = true
    end

    @errors
  end

  def class_for(field)
    errors[field] ? "has-error" : ""
  end
end
