if Star.any?
  puts "  ---> Warning! Didn't load, already exists."
else
  500.times do
    @date ||= Time.now

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
end
