class StarsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'stars'
  end
end
