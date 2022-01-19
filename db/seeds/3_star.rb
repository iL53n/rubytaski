unless Star.any?
  100.times do
    @date ||= Time.zone.now

    Task.all.each do |task|
      create = [true, false].sample

      Star.create!(
        user:     User.first,
        task:     task,
        due_date: @date
      ) if create
    end

    @date -= 86_400
  end
else
  puts "  ---> Warning! Didn't load, already exists."
end
