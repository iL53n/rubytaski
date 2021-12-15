class TasksController < ApplicationController
  # before_action :authenticate_user!
  before_action :load_task, only: %i[show destroy]

  layout false

  def index
    @tasks = Task.includes(:stars)
    render json: TaskSerializer.new(@tasks).serialized_json
    # render json: TaskSerializer.new(@tasks, include: [:stars]).serializable_hash
  end

  def create
    @task = Task.new(task_params)
    @task.user = User.first

    if @task.save!
      render json: TaskSerializer.new(@task).serialized_json, status: :created
    else
      render json: { errors: @task.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: TaskSerializer.new(@task).serialized_json, status: :ok
  end

  def destroy
    @task.destroy
  end

  private

  def load_task
    @task ||= Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:id,
                                 :title,
                                 :description)
  end
end
