class GoalsController < ApplicationController
  # before_action :authenticate_user!
  before_action :load_goal, only: %i[show update set_state destroy]
  after_action  :broadcast, only: %i[create update set_state destroy]

  layout false

  def index
    scope = Goal.where(user: current_user)
    @goals = ::QueryBuilder.new(params, scope)
    render status: :ok
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user

    if @goal.save
      render status: :created,
        json: {notice: "Goal was successfully created."}
    else
      error_response(@goal, :unprocessable_entity)
    end
  end

  def show
    render status: :ok
  end

  def update
    if @goal.update(goal_params)
      render status: :ok,
        json: {notice: "Successfully updated goal."}
    else
      error_response(@goal, :unprocessable_entity)
    end
  end

  def set_state
    state = goal_params[:state]
    if @goal.send(state)
      render status: :ok,
        json: {notice: "Successfully changed goals state."}
    else
      error_response(@goal, :unprocessable_entity)
    end
  end

  def destroy
    if @goal.destroy
      render status: :ok,
        json: {notice: "Successfully deleted goal."}
    else
      error_response(@goal, :unprocessable_entity)
    end
  end

  private

  def load_goal
    @goal ||= Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(
      :id,
      :state,
      :start_date,
      :due_date,
      :number_of_stars,
      :prize
    )
  end

  def broadcast
    return if @goal.errors.any?

    ActionCable.server.broadcast("goals", {goal: @goal})
  end
end
