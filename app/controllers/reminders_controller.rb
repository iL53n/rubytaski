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

  def reminder_params
    params.require(:reminder).permit(
      :task_id,
      :recurrence,
      :remind_at,
      days: []
    )
  end
end
