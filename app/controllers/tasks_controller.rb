class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = Task.preload(:stars)
    render json: TaskSerializer.new(@tasks).serialized_json
  end
end
