desc "load schema and create development data"
task :db! => :environment do
  Rake::Task["db:reset"].invoke
  Rake::Task["create_development_data"].invoke
end
