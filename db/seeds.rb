Dir[Rails.root.join('db', 'seeds', '**', '*.rb')].sort.each do |seed_file|
  puts "  - Loading seeds from: #{File.basename(seed_file)}"
  require seed_file
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?