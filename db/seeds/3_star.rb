unless Star.any?
  [0, 1, 2].each do |state|
    Star.create!(
      state: state,
      user:     User.first,
      task:     Task.first,
      due_date: Time.zone.now
    )
  end
end