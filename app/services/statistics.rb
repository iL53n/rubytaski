class Statistics
  def initialize(params = {})
    @stars = params[:stars]
    @tasks = params[:tasks]
    @goal  = params[:goal]
  end

  def date_count
    @stars.group_by(&:due_date).transform_values(&:count).map do |key, value|
      { date: key, count: value }
    end
  end

  def stars_stat
    {
      all:           @stars.count,
      current_year:  stars_count_between_dates('year'),
      current_month: stars_count_between_dates('month'),
      current_week:  stars_count_between_dates('week'),
      today:         stars_count_between_dates('day')
    }
  end

  def current_stat
    {
      all_today: @tasks.count,
      done_today: stars_count_between_dates('day'),
      all_week: @tasks.count * 7,
      done_week: stars_count_between_dates('week'),
      all_goal: @goal.number_of_stars,
      done_goal: @stars.where('due_date BETWEEN ? AND ?', @goal.start_date, @goal.due_date).count
    }
  end

  private

  def stars_count_between_dates(period)
    @stars.where('due_date BETWEEN ? AND ?',
                  DateTime.now.send("beginning_of_#{period}"), DateTime.now.send("end_of_#{period}")).count
  end
end
