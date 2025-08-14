class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    # client = IEX::Api::Client.new(publishable_token: '<<secret_token>>',
    #                               endpoint: 'https://sandbox.iexapis.com/v1')
    # client.price(ticker_symbol)
    SecretStockData[ticker_symbol] || -1
  end

  private

  SecretStockData = {
    'GOOG' => 1234,
    'APPL' => 2345,
    'MSFT' => 3456,
  }
end
