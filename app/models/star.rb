class Star < ApplicationRecord
  validates :state, presence: true

  belongs_to :user
  belongs_to :task

  # https://github.com/amatsuda/stateful_enum
  enum state: { created: 0, planned: 1, done: 2 } do
    event :plan do
      transition created: :planned
    end

    event :complete do
      before do
        self.done_date = Time.zone.now
      end

      transition planned: :done
    end
  end
end
