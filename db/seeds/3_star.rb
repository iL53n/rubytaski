unless Star.any?
  Task.all.each do |task|
    @date = Time.zone.now

    [0, 1, 2].each do |state|
      Star.create!(
        state: state,
        user:     User.first,
        task:     task,
        due_date: @date
      )

      @date += 86400
    end
  end
end