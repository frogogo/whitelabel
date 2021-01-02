source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1', '>= 6.1.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server.
gem 'puma', '~> 5.1'
gem 'rack-cors', '~> 1.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6.0.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.10'
# Use Redis adapter to run Action Cable in production
gem 'hiredis', '~> 0.6'
gem 'redis', '~> 4.2', require: ['redis', 'redis/connection/hiredis']
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1'

gem 'http_accept_language', '~> 2.1'

gem 'faraday', '~> 1.3'
gem 'slack-ruby-client', '~> 0.15'

# TODO: change to stable version after release v2.2.0
gem 'knock', github: 'nsarno/knock', branch: 'master'
gem 'versioncake', '~> 4.0'

# Image processing
gem 'carrierwave', '~> 2.1'
gem 'fog-aws', '~> 3.7'

# Use Trestle as admin framework
gem 'trestle', '~> 0.9'
gem 'trestle-auth', '~> 0.4'
gem 'trestle-search', '~> 0.4'

# Use Rollbar
gem 'rollbar', '~> 3.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 4.0'
end

group :development do
  gem 'annotate', '~> 3.1'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.4'
  gem 'web-console', '>= 4.1.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0'
  # Use Rubocop
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :production do
  gem 'sidekiq', '~> 6.1'
  gem 'uglifier', '~> 4.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
