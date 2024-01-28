class ReminderWorker
  include Sidekiq::Worker

  def perform(task_id)
    task = Task.find_by(id: task_id)
    return unless task

    ActionCable.server.broadcast('reminders', { task: task })
  end
end
