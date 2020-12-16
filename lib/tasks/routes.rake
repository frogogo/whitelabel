# TODO: Remove task after annotate update:
# https://github.com/ctran/annotate_models/issues/845

task routes: :environment do
  require 'rails/commands/routes/routes_command'
  Rails.application.require_environment!
  cmd = Rails::Command::RoutesCommand.new
  cmd.perform
end
