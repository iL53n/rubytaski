require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of :title }
  it { should belong_to :user }
  it { should have_many :stars }

  describe 'Calculated values' do
    let(:user) { create(:user) }
    let(:task) { create(:task, user: user) }
    let!(:stars) { create_list(:star, 7, user: user, task: task) }

    it '#stars_count' do
      expect(task.stars_count).to eq(stars.count) # 7
    end
  end
end
