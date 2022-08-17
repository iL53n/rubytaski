class StatisticsController < ApplicationController
  layout false

  def index
    @stat = StatisticsService.new(params.merge(current_user: current_user))
    render status: :ok
  end
end
