require 'csv'

namespace :csv_load do
  desc "imports items.csv data"
  task :items => :environment do

    items_path = 'db/data/items.csv'
    CSV.foreach(items_path, headers: true) do |row|
      name = row['name']
      description = row['description']
      unit_price = row['unit_price'].to_i
      merchant_id = row['merchant_id'].to_i
      Item.create(name: name, description: description, unit_price: unit_price, merchant_id: merchant_id)
    end
  end
end