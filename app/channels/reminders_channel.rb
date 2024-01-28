class RemindersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "reminders"
  end
end
