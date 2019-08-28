require 'date'

class Package
  attr_reader :id, :carrier_code, :shipping_date

  def initialize(id, carrier, shipping_date)
    @id = id
    @carrier = carrier
    @shipping_date = Date.strptime(shipping_date, '%Y-%m-%d')
  end

  def get_delivery_date
    carrier_days = @carrier.delivery_promise + 1
    delivery_date = (@shipping_date + carrier_days).strftime('%Y-%m-%d')
  end

end