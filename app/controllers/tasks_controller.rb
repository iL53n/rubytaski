class TasksController < ApplicationController
  # before_action :authenticate_user!
  before_action :load_task, only: %i[show update destroy]

  layout false

  def index
    scope = Task.preload(:stars)
    @tasks = ::QueryBuilder.new(params, scope)
    render status: :ok
  end

  def create
    @task = Task.new(task_params)
    @task.user = User.first

    if @task.save!
      render status: :created,
        json: { notice: 'Task was successfully created.' }
    else
      render status: :unprocessable_entity,
        json: { error: @task.errors.full_messages.to_sentence }
    end
  end

  def show
    render status: :ok
  end

  def update
    if @task.update(task_params)
      render status: :ok,
        json: { notice: 'Successfully updated task.' }
    else
      render status: :unprocessable_entity,
        json: { error: @task.errors.full_messages.to_sentence }
    end
  end

  def destroy
    if @task.destroy
      render status: :ok,
        json: { notice: 'Successfully deleted task.' }
    else
      render status: :unprocessable_entity,
        json: { error: @task.errors.full_messages.to_sentence }
    end
  end

  private

  def load_task
    @task ||= Task.find(params[:id])
    unless @task
      render status: :not_found,
        json: { error: t('task.not_found') }
    end
  end

  def task_params
    params.require(:task).permit(:id,
                                 :title,
                                 :description)
  end
end
