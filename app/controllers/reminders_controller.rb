class RemindersController < ApplicationController
  def create
    reminder = Reminder.new(reminder_params)

    if reminder.save
      render status: :created,
        json: {notice: "Reminders was successfully created."}
    else
      error_response(reminder, :unprocessable_entity)
    end
  end

  def destroy
    task = Task.find_by(id: params[:task_id])
    reminder = task.reminder

    if reminder.destroy
      render status: :ok,
        json: {notice: "Successfully deleted reminder."}
    else
      error_response(reminder, :unprocessable_entity)
    end
  end

  private

  def reminder_params
    params.require(:reminder).permit(
      :task_id,
      :recurrence,
      :remind_at,
      days: []
    )
  end
end
