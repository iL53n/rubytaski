unless Star.any?
  @date = Time.zone.now
  [0, 1, 2].each do |state|
    Star.create!(
      state: state,
      user:     User.first,
      task:     Task.first,
      due_date: @date
    )

    @date += 86400
  end
end