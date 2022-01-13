json.goal do
  json.extract! @goal,
    :id,
    :start_date,
    :due_date,
    :number_of_stars,
    :prize
end
