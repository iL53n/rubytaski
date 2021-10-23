class TasksController < ApplicationController
  # before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :load_task, only: :destroy

  def index
    @tasks = Task.includes(:stars)
    render json: TaskSerializer.new(@tasks).serialized_json
    # render json: TaskSerializer.new(@tasks, include: [:stars]).serializable_hash
  end

  def destroy
    @task.destroy
  end

  private

  def load_task
    @task ||= Task.find(params[:id])
  end
end
