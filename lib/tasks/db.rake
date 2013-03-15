desc "load schema and create development data"
task :db! => :environment do
  Rake::Task["db:schema:load"].invoke
  Rake::Task["db:seed"].invoke
  Rake::Task["db:test:prepare"].invoke if Rails.env.development?
  Rake::Task["create_development_data"].invoke
end
