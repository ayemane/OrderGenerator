namespace :generate do
  desc "TODO"
  task orders: :environment do
    OrdersGenerator.new.process(count: 100)
  end
end
