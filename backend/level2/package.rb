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

    day = 0
    while day < carrier_days do

      if (shipping_date + day).wday == 5 && !@carrier.saturday_deliveries
        carrier_days += 1
      elsif (shipping_date + day).wday == 6
        carrier_days += 1
      end
      day += 1
    end
    delivery_date = (@shipping_date + carrier_days).strftime('%Y-%m-%d')
  end

end