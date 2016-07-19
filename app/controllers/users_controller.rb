class UsersController < ApplicationController

  def create
    special_ips = [
      '::1', # localhost ip
      '98.27.51.234', # cruz/home
      '162.192.161.9'
    ]

    email = params[:user][:email]
    ip = special_ips.include?(request.ip) ? 'none' : request.ip

    if email.present? && User.find_by_email(email)
      @user = User.find_by_email(email)
    elsif User.find_by_ip_address(ip)
      @user = User.find_by_ip_address(ip)
    else
      @user = User.new(user_params.merge(ip_address: request.ip))
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
