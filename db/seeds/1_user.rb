unless User.any?
  User.create!(
    email: 'user@test.com',
    password: '123456',
    password_confirmation: '123456'
  )
else
  puts "  ---> Warning! Didn't load, already exists."
end
