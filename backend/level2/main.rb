require 'date'
require 'json'
require_relative 'package'
require_relative 'carrier'

input_data = File.read('./data/input.json')

carrier_list = {}
data = JSON.parse(input_data)
res = { deliveries: [] }

data['carriers'].each do |carrier|
  carrier_list[carrier['code']] = Carrier.new(carrier['code'], carrier['delivery_promise'], carrier['saturday_deliveries'])
end

data['packages'].each do |package|

  package_object = Package.new(package['id'], carrier_list[package['carrier']], package['shipping_date'])

  pack_info = {
    package_id: package_object.id,
    expected_delivery: package_object.get_delivery_date,
  }
  res[:deliveries].push(pack_info)
end

File.write('data/output.json', JSON.pretty_generate(res))
