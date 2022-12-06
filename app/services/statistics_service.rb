class StatisticsService
  attr_reader :params

  def initialize(params)
    @params = params
    @performed_scope = {}
    perform_scope
  end

  def perform_scope
    @scopes = @params[:scopes]
    return unless @scopes.present?

    @scopes = @scopes.split(',')
    @scopes.each do |scope|
      @performed_scope[scope] = send(scope.to_sym) if public_methods.respond_to?(scope.to_sym)
    end
    @performed_scope
  end

  def stars_date_count
    # [
    #   [1660048252000,0],
    #   [1661048252000,6],
    #   [1662048252000,13],
    #   [1664048252000,3],
    #   [1666048252000,11],
    #   [1668048252000,1],
    #   [1670059353000,9], // .to_i * 1000
    # ]
    # data = stars_count_by_date.map { |k, v| [k, v] }

    arr = []
    stars_group_by_date.transform_values(&:count).each do |key, value|
      arr << [(key.to_i * 1000), value]
    end
    arr

    # wrap_for_apexchart(arr)
  end

  def stars_stat
    {
      all: stars_count,
      current_year: stars_for_year_count,
      current_month: stars_for_month_count,
      current_week: stars_for_week_count,
      current_day: stars_for_day_count,
    }
  end

  def heatmap_chart
    stars_group_by_date.transform_values(&:count).map do |key, value|
      { date: key, count: value }
    end
  end

  # private

  def current_user
    @current_user ||= params[:current_user]
  end

  # Core variables
  def stars
    @stars ||= Star.where(user: current_user)
  end

  def tasks
    @tasks ||= Task.where(user: current_user)
  end

  def goals
    @goals ||= Goal.where(user: current_user)
  end

  # Count
  def stars_count
    stars.count
  end

  def tasks_count
    tasks.count
  end

  def goal_count
    goal.count
  end

  # Stars
  ## for
  def stars_for_year
    stars_between('year')
  end

  def stars_for_year_count
    stars_for_year.count
  end

  def stars_for_month
    stars_between('month')
  end

  def stars_for_month_count
    stars_for_month.count
  end

  def stars_for_week
    stars_between('week')
  end

  def stars_for_week_count
    stars_for_week.count
  end

  def stars_for_day
    @stars.where(due_date: Date.current)
  end

  def stars_for_day_count
    stars_for_day.count
  end

  def stars_between(period)
    @stars.where('due_date BETWEEN ? AND ?',
                 DateTime.now.send("beginning_of_#{period}"), DateTime.now.send("end_of_#{period}"))
  end

  ## group by
  # necessary @ ?
  def stars_group_by_date
    @stars.group_by(&:due_date)
  end

  def stars_group_by_task
    @stars.group_by(&:task_id)
  end

  ## count by
  def stars_count_by_year
    stars_count_by('%Y')
  end

  def start_count_by_month
    stars_count_by('%m')
  end

  def stars_count_by_week
    stars_count_by('%W')
  end

  def stars_count_by_date
    stars_count_by('%d/%m/%Y')
  end

  def stars_count_by_wday
    stars_count_by('%A')
  end

  def stars_count_by(directive)
    hash = {}
    stars_group_by_date.transform_values(&:count).each do |key, value|
      hash[key.strftime(directive)] ||= 0
      hash[key.strftime(directive)] += value
    end
    hash
  end

  # def stars_by_task
  #   stars_group_by_task.transform_values(&:count)
  # end



  # Stats
  def general_stat
    {
      active_days: stars.uniq(&:due_date).count
    }
  end

  def tasks_stat
    {
      all: tasks.count,
      all_active: tasks.created.count
    }
  end

  def goals_stat
    {
      all: tasks.count,
      current: {
        id: current_active_goal.id,
        number_of_stars: current_active_goal.number_of_stars,
        completed_stars: stars.where('due_date BETWEEN ? AND ?',
                                     current_active_goal.start_date, current_active_goal.due_date).count
      }
    }
  end



  # Charts

  def treemap_chart
    data = stars_group_by_task.transform_values(&:count).map do |key, value|
      { x: key.title, y: value }
    end
    wrap_for_apexchart(data)

    # wday-count
    # stars_by_due_date('%A').transform_values(&:count).map ...
  end
  
  def wrap_for_apexchart(data)
    [{ data: data }]
  end

  # Data for charts
  def stars_group_by_task
    @stars_group_by_task ||= stars.preload(:task).group_by(&:task)
  end

  def stars_by_due_date(format)
    stars.group_by { |star| star.due_date.strftime(format) }
  end

  def current_active_goal
    @current_active_goal ||= goals.created.first
  end

  def stars_count_between_dates(period)
    @stars.where('due_date BETWEEN ? AND ?',
                 DateTime.now.send("beginning_of_#{period}"), DateTime.now.send("end_of_#{period}")).count
  end
end
