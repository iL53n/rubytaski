require 'sidekiq-scheduler'

class ReminderScheduler
  include Sidekiq::Worker

  def perform
    current = Time.now.getutc
    current_wday = current.wday
    current_time = current.strftime('%H:%M')

    log_msg = "check reminders for wday: #{current_wday}, time: #{current_time}"
    Rails.logger.info(log_msg)

    Reminder.on_day(current_wday).each do |reminder|
      ReminderWorker.perform_async(reminder.task_id) if reminder.remind_at == current_time
    end
  end
end
