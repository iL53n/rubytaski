date = Time.zone.now
start_date = date - (86400 * 15)
due_date = date + (86400 * 15)
number_of_stars = (Task.all.count * 30 * 0.75).round(-1)
prize = 'PlayStation5'

unless Goal.any?
  Goal.create!(
    state: 0,
    start_date: start_date,
    due_date: due_date,
    number_of_stars: number_of_stars,
    prize: prize,
    user: User.first
  )
else
  puts "  ---> Warning! Didn't load, already exists."
end
