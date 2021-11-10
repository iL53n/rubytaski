class StarsController < ApplicationController
  # before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :load_star, only: %i[update destroy]
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

  # def update
  #   if @star.update(star_params)
  #     render json: StarSerializer.new(@star).serialized_json, status: :created
  #   else
  #     render json: { errors: @star.errors }, status: :unprocessable_entity
  #   end
  # end

  def destroy
    @star.destroy
  end

  def statistics
    render json: Statistics.new(Star.all).date_count
  end

  private

  def load_star
    @star ||= Star.find(params[:id])
  end

  def load_task
    @task = Task.find(params[:task_id])
  end

  def star_params
    params.require(:star).permit(:id,
                                :state,
                                :user,
                                :task_id,
                                :due_date,
                                :done_date,
                                star: [])
  end
end
