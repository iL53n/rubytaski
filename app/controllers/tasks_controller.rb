class TasksController < ApplicationController
  # before_action :authenticate_user!

  def index
    @tasks = Task.includes(:stars)
    render json: TaskSerializer.new(@tasks).serialized_json
    # render json: TaskSerializer.new(@tasks, include: [:stars]).serializable_hash
  end
end
