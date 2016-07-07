class UsersController < ApplicationController

  def create
    @connections = params[:user][:connections]
    if params[:user][:email].present? && User.find_by_email(params[:user][:email])
      @user = User.find_by_email(params[:user][:email])
    else
      @user = User.new(user_params)
    end

    if @user.save
      session[:user] = @user.id
      redirect_to menu_path
    else
      redirect_to '/'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :phone_number, :connection_other, :language, connections: []
    )
  end
end
