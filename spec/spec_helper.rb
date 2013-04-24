# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'
require 'selenium/webdriver'

# For a stubborn spec, switch the driver to :chrome and put a binding.pry
# before the failure. Once the pry console is hit, you can interact with
# the Chrome window it's been driving, with everything in the proper state.
# Even works for javascript heavy single-page apps!
Capybara.javascript_driver = :poltergeist

Capybara.register_driver :chrome do |app|
  profile = Selenium::WebDriver::Chrome::Profile.new
  profile['extensions.password_manager_enabled'] = false
  Capybara::Selenium::Driver.new(app, browser::chrome, profile::profile)
end

include Warden::Test::Helpers

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end
 
  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include FactoryGirl::Syntax::Methods
  config.color_enabled = true
end
