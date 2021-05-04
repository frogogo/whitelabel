ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def api_headers
    {
      'Accept' => 'application/json',
      'Accept-Language' => 'ru-RU;q=1.0, en-RU;q=0.9',
      'Content-Type' => 'application/json'
    }
  end
end
