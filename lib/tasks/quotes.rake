namespace :quotes do
  task :fetch => :environment do
    Quote.fetch
  end

  task :send => :environment do
    Quote.find_users
  end
end
