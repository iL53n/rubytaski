json.goal do
  json.extract! @goal,
    :id,
    :state,
    :start_date,
    :due_date,
    :number_of_stars,
    :prize
end
