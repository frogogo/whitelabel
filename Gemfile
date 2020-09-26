source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3.6'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6.0.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.10.0'
# Use Redis adapter to run Action Cable in production
gem 'hiredis', '~> 0.6.3'
gem 'redis', '~> 4.2.1', require: ['redis', 'redis/connection/hiredis']
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.16'

# Use Active Storage variant
gem 'aws-sdk-s3', '~> 1.79.0', require: false
gem 'image_processing', '~> 1.11.0'

gem 'faraday', '~> 1.0.1'

# TODO: change to stable version after release v2.2.0
gem 'knock', github: 'nsarno/knock', branch: 'master'
gem 'versioncake', '~> 4.0.2'

# Use Trestle as admin framework
gem 'trestle', '~> 0.9.3'
gem 'trestle-auth', '~> 0.4.0'
gem 'trestle-search', '~> 0.4.2'

# Use Rollbar
gem 'rollbar', '~> 3.0.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Use RSpec
  gem 'rspec-rails', '~> 4.0.1'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.2.1'
  gem 'web-console', '>= 4.0.4'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.1'
  # Use Rubocop
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  # Use Annotate
  gem 'annotate', '~> 3.1.1'
end

group :production do
  # Use Sidekiq
  gem 'sidekiq', '~> 6.1.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
