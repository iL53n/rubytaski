class StarsController < ApplicationController
  # before_action :authenticate_user!
  before_action :load_star, only: %i[update destroy]
  before_action :load_task, only: :create

  layout false

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

  # Stats
  # TODO: move to a separate service
  def heatmap_stat
    render json: Statistics.new(stars: Star.all).date_count
  end

  def stars_stat
    render json: Statistics.new(stars: Star.all).stars_stat
  end

  def current_stat
    render json: Statistics.new(stars: Star.all,
                                tasks: Task.all,
                                goal: Goal.created.first).current_stat
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
