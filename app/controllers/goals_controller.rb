class GoalsController < ApplicationController
  # before_action :authenticate_user!
  before_action :load_goal, only: %i[show destroy]

  layout false

  def index
    @goals = Goal.all
    render json: GoalSerializer.new(@goals).serialized_json
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = User.first

    if @goal.save!
      render json: GoalSerializer.new(@goal).serialized_json, status: :created
    else
      render json: { errors: @goal.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: GoalSerializer.new(@goal).serialized_json, status: :ok
  end

  def update; end

  def destroy
    @goal.destroy
  end

  private

  def load_goal
    @goal ||= Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:id,
                                 :state,
                                 :start_date,
                                 :due_date,
                                 :number_of_stars,
                                 :prize)
  end
end
