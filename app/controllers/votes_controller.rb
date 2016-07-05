class VotesController < ApplicationController
  before_action :set_user, only: :create
  before_action :set_vote, only: :update

  def index
    @votes = Vote.all
    @dishes = Dish.all
    @entrees = Dish.where(priority: 'entree').where.not(votes: 0).order(votes: :desc).limit 10
    @desserts = Dish.where(priority: 'dessert').where.not(votes: 0).order(votes: :desc).limit 10
    @drinks = Dish.where(priority: 'drink').where.not(votes: 0).order(votes: :desc).limit 10
    respond_to do |format|
      format.html
      format.csv { render text: @votes.to_csv(request.path[9..10])}
    end
  end

  def create
    @vote = Vote.new(vote_params.merge(user: @user))

    if @vote.save
      @vote.add_tallies
      redirect_to comments_path
    else
      redirect_to request.referer, notice: 'not happening'
    end
  end

  def update
    bad_commits = ['No thanks', 'No gracias']
    if bad_commits.include? params['commit']
      redirect_to thank_you_path
    else
      if @vote.update(vote_params)
        redirect_to thank_you_path
      else
        redirect_to comments_path
      end
    end
  end

  def vote_params
    params.require(:vote).permit(:entree, :dessert, :drink, :comments)
  end

  def set_user
    @user = User.find session[:user]
  end

  def set_vote
    @vote = Vote.find params[:id]
  end
end
