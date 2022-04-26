class TasksController < ApplicationController
  # before_action :authenticate_user!
  before_action :load_task, only: %i[show update set_state destroy]
  after_action  :broadcast, only: %i[create update destroy]

  layout false

  def index
    scope = Task.where(user: current_user).preload(:stars)
    @tasks = ::QueryBuilder.new(params, scope)
    render status: :ok
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user

    if @task.save
      render status: :created,
        json: {notice: "Task was successfully created."}
    else
      fail!(:unprocessable_entity, full_errors_msg(@task))
    end
    # fail!(:unprocessable_entity, @task.errors.full_messages.to_sentence) unless @task.save
  end

  def show
    render status: :ok
  end

  def update
    if @task.update(task_params)
      render status: :ok,
        json: {notice: "Successfully updated task."}
    else
      fail!(:unprocessable_entity, full_errors_msg(@task))
    end
  end

  def update_order
    if Task.change_order(order_params)
      render status: :ok,
        json: {notice: "Successfully updated order."}
    else
      fail!(:unprocessable_entity)
    end
  end

  def set_state
    state = task_params[:state]
    if @task.send(state)
      render status: :ok,
        json: {notice: "Successfully changed tasks state."}
    else
      fail!(:unprocessable_entity, full_errors_msg(@task))
    end
  end

  def destroy
    if @task.destroy
      render status: :ok,
        json: {notice: "Successfully deleted task."}
    else
      fail!(:unprocessable_entity, full_errors_msg(@task))
    end
  end

  private

  def load_task
    @task ||= Task.find(params[:id])
    fail!(:not_found, "Task not found") unless @task
  end

  def task_params
    params.require(:task).permit(
      :id,
      :state,
      :title,
      :description,
      :order,
      :scopes
    )
  end

  # TODO: add keys for data :id, :order AND destroy .permit!
  def order_params
    params.require(:order).permit!
  end

  def broadcast
    return if @task.errors.any?

    ActionCable.server.broadcast("tasks", {task: @task})
  end
end
