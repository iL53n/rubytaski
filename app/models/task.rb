class Task < ApplicationRecord
  validates :title, presence: true
  before_create :set_order

  belongs_to :user
  has_many :stars, dependent: :destroy

  def self.change_order(order)
    order.each do |id, value|
      Task.find(id).update(order: value)
    end
  end

  # calculated values
  # TODO: move to separate space?)
  def stars_count
    stars.count
  end

  def current_streak
    streaks.last
  end

  def longest_streak
    streaks.max
  end

  private

  def streaks
    streaks = []
    n = 1
    previous_date = stars.first.due_date.to_date

    stars.each do |star|
      current_date = star.due_date.to_date

      current_date == previous_date + 1.day ? n += 1 : n = 1

      previous_date = current_date
      streaks << n
    end

    streaks
  end

  def set_order
    self.order ||= Task.count
  end
end
