class Reminder < ApplicationRecord
  belongs_to :task

  validates :remind_at, presence: true
  validates :recurrence, inclusion: { in: %w[daily weekly monthly], message: 'must be daily, weekly, or monthly' }

  before_save :destroy_previous_reminder, if: :will_save_change_to_task_id?

  scope :on_day, ->(day_number) { where('? = ANY(days)', day_number.to_s) }

  private

  def destroy_previous_reminder
    # TODO: doesn't work because try to destroy unsaved instance instead of prev one
    # if task.present? && task.reminder.present?
    #   task.reminder.destroy
    # end

    task = Task.find_by(id: self.task_id)
    task.reminder&.destroy if task.present?
  end
end
