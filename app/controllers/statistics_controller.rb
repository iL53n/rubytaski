class StatisticsController < ApplicationController
  layout false

  def index
    @stat = StatisticsService.new(params)
    render status: :ok
  end
end
