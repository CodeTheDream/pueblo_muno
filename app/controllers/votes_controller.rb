class VotesController < ApplicationController
  before_action :set_user, only: :create

  def index
    @votes = Vote.all.reverse
    @dishes = Dish.order(votes: :desc).limit 10
    @entrees = Dish.where(priority: 'entree').where.not(votes: 0).order(votes: :desc).limit 10
    @desserts = Dish.where(priority: 'dessert').where.not(votes: 0).order(votes: :desc).limit 10
    @drinks = Dish.where(priority: 'drink').where.not(votes: 0).order(votes: :desc).limit 10
  end

  def create
    @vote = Vote.new(vote_params.merge(user: @user))

    if @vote.save
      @vote.add_tallies
      redirect_to thank_you_path
    else
      redirect_to request.referer, notice: 'not happening'
    end
  end

  def vote_params
    params.require(:vote).permit(:entree, :dessert, :drink)
  end

  def set_user
    @user = User.find session[:user]
  end
end
