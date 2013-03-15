desc "create development data"
task :create_development_data => :environment do
  ActionMailer::Base.delivery_method = :test
  require 'demo_data'
  DemoData.load
end
