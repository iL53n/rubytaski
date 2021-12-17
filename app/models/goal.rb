class Goal < ApplicationRecord
  validates :state,
            :start_date,
            :due_date,
            :number_of_stars,
            :prize, presence: true
  belongs_to :user

  enum state: { created: 0, done: 1, archived: 5 } do
    event :complete do
      transition created: :done
    end

    event :archive do
      transition created: :archived
    end
  end
end
