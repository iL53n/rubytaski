require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of :title }
  it { should belong_to :user }
  it { should have_many :stars }

  describe 'Class methods' do
    it '.change_order(order)' do
      # TODO
    end
  end

  describe 'Instance methods' do
    let(:user) { create(:user) }
    let(:task) { create(:task, user: user) }

    context 'Calculated values' do
      let!(:stars) { create_list(:star, 7, user: user, task: task) }

      it '#stars_count' do
        expect(task.stars_count).to eq(stars.count) # 7
      end
    end

    context 'Streaks statistics' do
      before do
        # TODO: need optimization because call twice
        # Streaks 3---7---5
        arr = [1, 2, 3, 7, 8, 9, 10, 11, 12, 13, 17, 18, 19, 20, 21]
        arr.each do |el|
          date = Time.now + (86_400 * el)
          create(:star, due_date: date, task: task, user: user)
        end
      end

      it '#current_streak' do
        expect(task.current_streak).to eq(5)
      end

      it '#longest_streak' do
        expect(task.longest_streak).to eq(7)
      end
    end
  end
end
