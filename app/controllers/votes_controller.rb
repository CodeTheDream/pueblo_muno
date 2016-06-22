class VotesController < ApplicationController
  before_action :set_user

  def index
    @votes = Vote.all
    @dishes = Dish.order(votes: :desc)
  end

  def create
    # entree = params[:vote][:entree].size == 2 ?
    # dessert = params[:vote][:dessert] ?
    # drink = params[:vote][:drink] ?
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
    @user = User.find(session[:user])
  end
end
