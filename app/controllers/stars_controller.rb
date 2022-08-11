class StarsController < ApplicationController
  # before_action :authenticate_user!
  before_action :load_star, only: %i[update destroy]
  before_action :load_task, only: :create
  after_action  :broadcast, only: %i[create destroy]

  before_action :stars, only: %i[heatmap_stat stars_stat current_stat]
  before_action :tasks, only: :current_stat
  before_action :goal,  only: :current_stat

  layout false

  def create
    @star = Star.new(star_params)
    @star.user = current_user
    @star.task = @task

    if @star.is_unique?
      if @star.save
        render status: :created,
          json: {notice: "Star was successfully created."}
      else
        error_response(@star, :unprocessable_entity)
      end
    end
  end

  def show
    render status: :ok
  end

  # def update
  #   if @star.update(star_params)
  #     render status: :ok,
  #       json: { notice: 'Successfully updated star.' }
  #   else
  #     render status: :unprocessable_entity,
  #       json: { error: @star.errors.full_messages.to_sentence }
  #   end
  # end

  def destroy
    if @star.destroy
      render status: :ok,
        json: {notice: "Successfully deleted star."}
    else
      error_response(@star, :unprocessable_entity)
    end
  end

  # Stats
  # TODO: move to a separate service
  def heatmap_stat
    # TODO: date_count?
    render json: StatisticsService.new(stars: @stars).date_count
  end

  def stars_stat
    render json: StatisticsService.new(stars: @stars).stars_stat
  end

  def current_stat
    render json: StatisticsService.new(
      stars: @stars.active,
      tasks: @tasks.created,
      goal: Goal.created.first
    ).current_stat
  end

  private

  def stars
    @stars = Star.where(user: current_user)
  end

  def tasks
    @tasks = Task.where(user: current_user)
  end

  def goal
    @goal = Goal.where(user: current_user).created.first
  end

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

  def broadcast
    return if @star.errors.any?

    ActionCable.server.broadcast("stars", {star: @star})
  end
end
