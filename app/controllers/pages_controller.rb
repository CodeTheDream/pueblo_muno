class PagesController < ApplicationController
  def email
    session[:user] = nil
    @user = User.new
  end

  def menu
    @dishes = Dish.dishes
    @prices = Dish.prices
    @places = Dish.places
  end

  def thank_you
  end
end
