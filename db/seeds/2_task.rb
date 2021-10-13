unless Task.any?
  5.times do |n|
    Task.create!(
      title: "Task_#{n}",
      description: "description description description description description description description description ",
      user: User.first
    )
  end
end