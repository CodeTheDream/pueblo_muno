class PagesController < ApplicationController
  before_action :set_user, only: [:home, :menu, :thank_you]
  before_action :authenticate_user, only: :menu
  before_action :already_voted, only: [:menu]

  def start
    session[:user] = nil
    @user = User.new
  end

  def menu
    @dishes = Dish.dishes
    @prices = Dish.prices
    @places = Dish.places
    @reaches = Dish.reaches
    @vote = Vote.new
  end

  def thank_you
    # if @user.votes.count > 0
    #   @message = "You have already voted."
    # else
      @message = "Your answers have been recorded. You may leave this page now."
    # end
  end

  private

  def authenticate_user
    redirect_to(thank_you_path) && return unless session[:user]
  end

  def already_voted
    if @user.votes.count > 0
      redirect_to thank_you_path, notice: 'You have already voted'
    end
  end

  def set_user
    @user = User.find session[:user]
  rescue ActiveRecord::RecordNotFound
    @user = nil
  end
end
