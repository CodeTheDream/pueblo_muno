class PagesController < ApplicationController
  before_action :set_user, only: [:home, :menu, :thank_you, :comments]
  before_action :authenticate_user, only: [:menu]
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

  def comments
    if @user.votes.first.comments.present?
      redirect_to thank_you_path
    end
    @vote = @user.votes.first
  end

  def results
    @votes = Vote.all
    @dishes = Dish.all
    respond_to do |format|
      format.html
      format.csv { render text: @votes.votes_to_csv(params[:l])}
    end
  end

  def voters
    @votes = Vote.joins(:user)
    respond_to do |format|
      format.html
      format.csv { render text: @votes.voters_to_csv(params[:l])}
    end
  end

  def all_voters
    @voters = User.all.order(name: :asc).group_by{|x|x.votes.count}.sort
  end

  private

  def authenticate_user
    if @user.votes.size == 1
      redirect_to thank_you_path
    end
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
