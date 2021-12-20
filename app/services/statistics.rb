class Statistics
  def initialize(stars)
    @stars = stars
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

  private

  def stars_count_between_dates(period)
    @stars.where('due_date BETWEEN ? AND ?',
                  DateTime.now.send("beginning_of_#{period}"), DateTime.now.send("end_of_#{period}")).count
  end
end
