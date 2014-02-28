class GoalsController < ApplicationController

  def index
    @goals = Goal.where(:public => true)
    # fail
    render :index
  end

  def new
    @goal = Goal.new
    render :new
  end

  def create
    user = User.find(params[:user_id])
    user.goals.create(goal_params)
    redirect_to user_url(user)
  end

  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def destroy
    @goal = Goal.find(params[:id])
    user = @goal.user
    @goal.destroy!
    redirect_to user_url(user)
  end

  private
  def goal_params
    params.require(:goal).permit(:name, :public)
  end
end
