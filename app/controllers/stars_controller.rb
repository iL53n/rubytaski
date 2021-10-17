class StarsController < ApplicationController
  # before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :load_task, only: :create

  def create
    @star = Star.new(star_params)
    @star.user = User.first
    @star.task = @task

    if @star.save!
      render json: StarSerializer.new(@star).serialized_json, status: :created
    else
      render json: { errors: @star.errors }, status: :unprocessable_entity
    end
  end

  private

  def load_task
    @task = Task.find(params[:task_id])
  end

  def star_params
    params.permit(:state,
                  :user,
                  :due_date)
  end
end
