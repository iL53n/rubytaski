class Star < ApplicationRecord
  validates :state, presence: true
  validate :uniqueness_task_user_date

  belongs_to :user
  belongs_to :task

  # https://github.com/amatsuda/stateful_enum
  # enum state: { created: 0, planned: 1, done: 2 } do
  #   event :plan do
  #     transition created: :planned
  #   end

  #   event :complete do
  #     before do
  #       self.done_date = Time.zone.now
  #     end

  #     transition planned: :done
  #   end
  # end

  def uniqueness_task_user_date
    if Star.where(user_id: user_id, task_id: task_id, due_date: due_date).exists?
      self.errors.add(:star, "already exists for the specified user, task and date")
    end
  end

  # after_save :broadcast
  # after_destroy :broadcast

  # def broadcast
  #   ActionCable.server.broadcast('stars', { star: self })
  # end
end
