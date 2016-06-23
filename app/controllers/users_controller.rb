class UsersController < ApplicationController
  def show
    authorize! :user, _user
    @user = _user
    @validator = UserValidator.new(@user)
  end

  def update
    authorize! :user, _user
    @user      = _user.update(_update_params)
    @validator = UserValidator.new(@user)

    if @validator.valid?
      @user.save
      flash[:notice] = "User updated"
      redirect_to root_url
    else
      flash[:error] = "Errors were detected"
      render 'show'
    end
  end

  private

  def _user
    @_user ||= UserDecorator.new(User[params[:id]])
  end

  def _update_params
    p = params.permit(:wants_notifications, :email)
    w = p.delete(:wants_notifications)
    { wants_notifications: (w == 'true'), email: p[:email] }
  end
end
