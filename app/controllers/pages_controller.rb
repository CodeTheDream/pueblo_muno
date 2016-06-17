class PagesController < ApplicationController
  def email
    session[:user] = nil
    @user = User.new
  end

  def menu
  end

  def thank_you
  end
end
