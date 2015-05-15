source 'https://rubygems.org'
ruby '2.0.0'

# PostgreSQL driver
# gem 'pg'
# commented out for heroku version.

# Sinatra driver
gem 'sinatra'
gem 'sinatra-contrib'

gem 'activesupport', '~>4.2.0'
gem 'activerecord', '~>4.2.0'

gem 'rake'

gem 'shotgun'
gem 'hirb'
gem 'amazon-ecs'
gem 'vacuum'

group :production do
  gem 'pg',             '0.17.1'
end

group :test do
  gem 'shoulda-matchers'
  gem 'rack-test'
  gem 'rspec', '~>3.0'
  gem 'capybara'
end

group :test, :development do
  gem 'factory_girl'
  gem 'faker'
  gem 'dotenv'
end
