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
  end

  def longest_streak
  end

  private

  def set_order
    self.order ||= Task.count
  end
end
