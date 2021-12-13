class Statistics
  def initialize(data)
    @data = data
  end

  def date_count
    @data.group_by(&:due_date).transform_values(&:count).map do |key, value|
      { date: key, count: value }
    end
  end
end
