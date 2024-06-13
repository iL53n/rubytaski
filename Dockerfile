# Use the official Ruby image as a base image
FROM ruby:3.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn redis-server

# Set working directory
WORKDIR /rubytaski

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install
RUN gem install foreman

# Install Node.js dependencies for Vue.js
COPY package.json yarn.lock ./
RUN yarn install

# Copy the rest of the application code
COPY . .

# Precompile assets for production
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose port 3000 for the Rails server
EXPOSE 3000

# Start the main process
CMD ["bundle", "exec", "foreman", "start", "-f", "Procfile.docker"]
