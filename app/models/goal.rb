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
      transition archived: :created
    end
  end

  def can_be_only_one_active_goal
    if Goal.where(user: self.user).created.exists? && created?
      errors.add(:goal, 'can be only one active instance')
    end
  end
end
