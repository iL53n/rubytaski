class Statistics
  attr_reader :performed_scope

  def initialize(params)
    @params = params
    @performed_scope = {}
    perform_scope
  end

  # TODO
  # private

  def perform_scope
    @scopes = @params[:scopes]
    return unless @scopes.present?

    @scopes = @scopes.split(',')
    @scopes.each do |scope|
      p scope
      @performed_scope[scope] = send(scope.to_sym) if respond_to?(scope.to_sym)
    end
    @performed_scope
  end

  # Stats
  def general_stat
    {
      active_days: stars.uniq(&:due_date).count
    }
  end

  def tasks_stat
    {
      all: tasks.count
    }
  end

  def goals_stat
    {
      all: tasks.count,
      current: {
        id: goal.id,
        number_of_stars: goal.number_of_stars,
        completed_stars: stars.where('due_date BETWEEN ? AND ?',
                                goal.start_date, @goal.due_date).count
      }
    }
  end

  def stars_stat
    {
      all:           stars.count,
      current_year:  stars_count_between_dates('year'),
      current_month: stars_count_between_dates('month'),
      current_week:  stars_count_between_dates('week'),
      current_day:   stars_count_between_dates('day')
    }
  end

  # Charts
  def heatmap_chart
    stars.group_by(&:due_date).transform_values(&:count).map do |key, value|
      { date: key, count: value }
    end
  end

  private

  # Varilables (lazy loading)
  def stars
    @stars ||= Star.all
  end

  def tasks
    @tasks ||= Task.all
  end

  def goals
    @goals ||= Goal.all
  end

  # Methods
  def stars_count_between_dates(period)
    @stars.where('due_date BETWEEN ? AND ?',
                  DateTime.now.send("beginning_of_#{period}"), DateTime.now.send("end_of_#{period}")).count
  end
end
