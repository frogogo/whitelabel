source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.2'
# Use Puma as the app server.
gem 'puma', '~> 5.2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.10'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.2'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1'

gem 'faraday', '~> 1.3'
gem 'slack-ruby-client', '~> 0.15'

# TODO: change to stable version after release v2.2.0
gem 'knock', github: 'nsarno/knock', branch: 'master'
gem 'versioncake', '~> 4.0'

# Use Trestle as admin framework
gem 'trestle', '~> 0.9'
gem 'trestle-auth', '~> 0.4'
gem 'trestle-search', '~> 0.4'

# Use Rollbar
gem 'rollbar', '~> 3.1'

gem 'rails-i18n', '~> 6.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'annotate', '~> 3.1'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.4'
  gem 'web-console', '>= 4.1.0'
  # Use Rubocop
  gem 'rubocop', require: false
end

group :production do
  gem 'sidekiq', '~> 6.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
