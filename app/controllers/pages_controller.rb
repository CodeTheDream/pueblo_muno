class PagesController < ApplicationController
  before_action :authenticate_user, only: :menu

  def email
    session[:user] = nil
    @user = User.new
  end

  def menu
    redirect_to thank_you_path, notice: 'You have already voted lmao' if @user.votes.count > 0
    @dishes = Dish.dishes
    @prices = Dish.prices
    @places = Dish.places
    @reaches = Dish.reaches
    @vote = Vote.new
  end

  def thank_you
  end

  private

  def authenticate_user
    redirect_to(root_path) && return unless session[:user]
    @user = User.find session[:user]
  end
end
