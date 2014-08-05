# This file is copied to spec/ when you run 'rails generate rspec:install'

ENV["RAILS_ENV"] ||= 'test'
ENV['WWQI_SITE'] ||= 'http://www.wwqidev.com'
ENV['WWQI_PERSON_THUMBNAIL'] ||= 'http://s3.amazonaws.com/assets.qajarwomen.org/thumbs'
ENV['HOST'] ||= 'wwqi.com'
ENV['SEARCH_URL'] ||= 'http://dwalin-us-east-1.searchly.com/wwqi-search-dev/item/_search'
ENV['SEARCH_AUTH'] ||= 'paas:8ee19088c92d6bea7906a87a64508df2'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'
require 'selenium/webdriver'
require 'vcr'


# For a stubborn spec, switch the driver to :chrome and put a binding.pry
# before the failure. Once the pry console is hit, you can interact with
# the Chrome window it's been driving, with everything in the proper state.
# Even works for javascript heavy single-page apps!
Capybara.javascript_driver = :poltergeist
#Capybara.javascript_driver = :chrome

Capybara.register_driver :chrome do |app|
  profile = Selenium::WebDriver::Chrome::Profile.new
  profile['extensions.password_manager_enabled'] = false
  Capybara::Selenium::Driver.new(app, browser: :chrome, profile: profile)
end

VCR.configure do |c|
  c.cassette_library_dir = 'support/vcr_cassettes'
  c.allow_http_connections_when_no_cassette = true
end

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
    DatabaseCleaner.strategy = :truncation
    # DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    Warden.test_reset!
  end

  config.after(:all) do
    if Rails.env.test?
      FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
    end
  end

  if defined?(CarrierWave)
    CarrierWave::Uploader::Base.descendants.each do |klass|
      next if klass.anonymous?
      klass.class_eval do
        def store_dir
          "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end
      end
    end
  end

  config.include FactoryGirl::Syntax::Methods
  config.include Warden::Test::Helpers
  config.include WaitSteps
  config.color_enabled = true
  config.include RSpec::Rails::RequestExampleGroup
end
