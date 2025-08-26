require 'net/http'
require 'uri'
require 'json'

class FmpCompany
  attr_reader :company_name, :symbol

  def initialize(company_name, symbol)
    @company_name = company_name
    @symbol = symbol
  end
end

class FmpClient
  COMPANY_ENDPOINT_URL = 'https://financialmodelingprep.com/stable/search-symbol'
  PRICE_ENDPOINT_URL = 'https://financialmodelingprep.com/stable/historical-price-eod/light'

  def initialize(api_key, fake_mode = false)
    @api_key = api_key
    @fake_mode = fake_mode
  end

  def price(symbol)
    body = @fake_mode ? fake_price_data : fetch_price_data(symbol)
    data = JSON.parse(body, symbolize_names: true)
    return data.sort{|lhs, rhs| rhs[:date] <=> lhs[:date]}[0][:price]
  end

  def company(symbol)
    body = @fake_mode ? fake_company_data : fetch_company_data(symbol)
    data = JSON.parse(body, symbolize_names: true)

    company = data.filter{|x| x[:exchange] == 'NASDAQ'}.first
    return nil if company.nil?

    FmpCompany.new(company[:name], company[:symbol])
  end

  private

  def fetch_price_data(symbol)
    fetch(PRICE_ENDPOINT_URL, { symbol: symbol })
  end

  def fake_price_data
    '[{"symbol": "AAPL","date": "2025-08-22","price": 227.76,"volume": 42477811},{"symbol": "AAPL","date": "2025-08-21","price": 224.9,"volume": 30621249},{"symbol": "AAPL","date": "2025-08-20","price": 226.01,"volume": 42263900}]'
  end

  def fetch_company_data(symbol)
    fetch(COMPANY_ENDPOINT_URL, { query: symbol })
  end

  def fake_company_data
    '[{ "symbol": "AAPL", "name": "AppleInc.", "currency": "USD", "exchangeFullName": "NASDAQGlobalSelect", "exchange": "NASDAQ" }, { "symbol": "AAPL.NE", "name": "AppleInc.", "currency": "CAD", "exchangeFullName": "CBOECA", "exchange": "NEO" }, { "symbol": "AAPL.MX", "name": "AppleInc.", "currency": "MXN", "exchangeFullName": "MexicanStockExchange", "exchange": "MEX" }, { "symbol": "AAPL.DE", "name": "AppleInc.", "currency": "EUR", "exchangeFullName": "DeutscheBörse", "exchange": "XETRA" }, { "symbol": "AAPLUSTRAD.BO", "name": "AAPlusTradelinkLimited", "currency": "INR", "exchangeFullName": "BombayStockExchange", "exchange": "BSE" }]'
  end

  def fetch(endpoint, query)
    endpoint_uri = URI.parse(endpoint)
    endpoint_uri.query = URI.encode_www_form(query.merge({ apikey: @api_key }))
    response = Net::HTTP.get_response(endpoint_uri)
    if response.code.to_i == 400
      raise 'Bad request: This request is invalid.'
    elsif response.code.to_i == 401
      raise 'Unauthorized: API key is mismatch.'
    elsif response.code.to_i != 200
      raise "Unknown error: #{response.code} / #{response.body}"
    end
    return response.body
  end
end
