release: rake db:migrate
web: bundle exec puma -C config/puma.rb
worker: bunde exec sidekiq -C config/sidekiq.yml