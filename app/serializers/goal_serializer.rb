class GoalSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :state, :start_date, :due_date, :number_of_stars, :prize
end
