require 'csv'


class OrdersGenerator

  FILE_NAME = "Orders-#{Time.now.strftime('%F%H%M%S')}.csv"

  def process(args={})
    number_of_records = args[:count] || 10
    output_path = args[:output_path] || Rails.root.join("public","orders")
    
    Dir.mkdir(output_path) unless Dir.exist?(output_path)
    
    CSV.open(output_path.join(FILE_NAME), 'wb') do |row|
      row << generate_order.keys

      number_of_records.times{ row << generate_order.values }
    end
  end

  private
  def generate_order
    make = Faker::Vehicle.make

    {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      full_address: Faker::Address.full_address,
      cc_num: Faker::Finance.credit_card(:mastercard, :visa),
      phone: Faker::PhoneNumber.phone_number,
      make: make,
      model: Faker::Vehicle.model(make),
      milage: Faker::Vehicle.mileage,
      price: Faker::Number.between(20000, 100000)
    }
  end
end