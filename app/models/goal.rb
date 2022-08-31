class Goal < ApplicationRecord
  validates :state,
            :start_date,
            :due_date,
            :number_of_stars,
            :prize, presence: true
  validate :can_be_only_one_active_goal, on: %i[create update]
  belongs_to :user

  enum state: { created: 0, done: 1, undone: 2, archived: 5 } do
    event :complete do
      transition created: :done
    end

    event :uncomplete do
      transition created: :undone
    end

    event :archive do
      transition created: :archived
    end

    event :unarchive do
      transition %i[archived done undone] => :created
    end
  end

  def can_be_only_one_active_goal
    if current_user_created_goal.exists? && (current_user_created_goal.first != self && created?)
      errors.add(:goal, "can be only one active instance")
    end
  end

  def current_user_created_goal
    Goal.where(user: user).created
  end

  def progress
    (completed_stars.to_f / number_of_stars * 100).round(0)
  end


  def completed_stars
    Star.where('due_date BETWEEN ? AND ?', start_date, due_date).count
  end
end
