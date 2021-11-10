class Statistics
  def initialize(data)
    @data = data
  end

  def date_count
    @data.group_by { |object| object.due_date }.transform_values {|values| values.count}.map do |key, value|
      {date: key, count: value}
    end
  end
end
