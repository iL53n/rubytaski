class GoalsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'goals'
  end
end
