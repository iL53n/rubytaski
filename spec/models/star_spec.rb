require 'rails_helper'

RSpec.describe Star, type: :model do
  it { should validate_presence_of :state }
  it { should belong_to :user }
  it { should belong_to :task }
end
