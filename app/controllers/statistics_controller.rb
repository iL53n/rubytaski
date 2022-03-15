class StatisticsController < ApplicationController
  layout false

  def index
    @stat = Statistics.new(params)
    render status: :ok
  end
end
