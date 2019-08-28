require 'date'
require 'json'
require_relative 'package'
require_relative 'carrier'
require_relative 'country'

input_data = File.read('./data/input.json')

countries_list = {}
carrier_list = {}
data = JSON.parse(input_data)
res = { deliveries: [] }

data['country_distance'].keys.each do |country|
  countries_list[country] = Country.new(country, data['country_distance'][country])
end

data['carriers'].each do |carrier|
  carrier_list[carrier['code']] = Carrier.new(carrier['code'], carrier['delivery_promise'], carrier['saturday_deliveries'], carrier['oversea_delay_threshold'])
end

data['packages'].each do |package|

  package_object = Package.new(package['id'], carrier_list[package['carrier']], package['shipping_date'], countries_list[package['origin_country']], countries_list[package['destination_country']])

  pack_info = {
    package_id: package_object.id,
    expected_delivery: package_object.get_delivery_date,
    oversea_delay: package_object.oversea_delay
  }
  res[:deliveries].push(pack_info)
end

File.write('data/output.json', JSON.pretty_generate(res))
