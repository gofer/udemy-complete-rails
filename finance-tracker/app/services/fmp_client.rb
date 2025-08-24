require 'net/http'
require 'uri'
require 'json'

class FmpClient
  ENDPOINT_URL = URI.parse('https://financialmodelingprep.com/stable/historical-price-eod/light')

  def initialize(api_key, fake_mode = false)
    @api_key = api_key
    @fake_mode = fake_mode
  end

  def price(symbol)
    body = @fake_mode ? fake_price_data : fetch_price_data(symbol)
    data = JSON.parse(body, symbolize_names: true)
    return data.sort{|lhs, rhs| rhs[:date] <=> lhs[:date]}[0][:price]
  end

  private

  def fetch_price_data(symbol)
    url = ENDPOINT_URL.dup
    url.query = URI.encode_www_form({ symbol: symbol, apikey: @api_key })
    response = Net::HTTP.get_response(url)
    if response.code.to_i == 400
      raise 'Bad request: This request is invalid.'
    elsif response.code.to_i == 401
      raise 'Unauthorized: API key is mismatch.'
    elsif response.code.to_i != 200
      raise "Unknown error: #{response.code} / #{response.body}"
    end
    return response.body
  end

  def fake_price_data
    '[{"symbol": "AAPL","date": "2025-08-22","price": 227.76,"volume": 42477811},{"symbol": "AAPL","date": "2025-08-21","price": 224.9,"volume": 30621249},{"symbol": "AAPL","date": "2025-08-20","price": 226.01,"volume": 42263900}]'
  end
end
