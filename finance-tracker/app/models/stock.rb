class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    # client = IEX::Api::Client.new(publishable_token: '<<secret_token>>',
    #                               endpoint: 'https://sandbox.iexapis.com/v1')
    # client.price(ticker_symbol)

    client = FmpClient.new(Rails.application.credentials.fmp_client[:api_key], true)
    new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
  end
end
