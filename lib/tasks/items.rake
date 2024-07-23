require 'csv'

namespace :csv_load do
  desc "imports merchants.csv data"
  task :merchants => :environment do

    merchants_path = 'db/data/merchants.csv'
    CSV.foreach(merchants_path, headers: true) do |row|
      name = row['name']
      Merchant.create(name: name)
    end
  end
end
