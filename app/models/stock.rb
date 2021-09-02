class Stock < ApplicationRecord
  has_many :transactions
  has_many :users, through: :transactions
  validates :symbol, { presence: true, uniqueness: true }

  #self: don't need an instance of stock class. can directly call this method from the class
  def self.iex_api
    IEX::Api::Client.new(
      publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
      secret_token: ENV['IEX_API_SECRET_TOKEN'],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
  end

  def self.new_lookup(symbol)
    client = self.iex_api
    begin
      new(symbol: symbol, company_name: client.quote(symbol).company_name, price: client.quote(symbol).latest_price)
    rescue StandardError
      #return nil in order to display a message through the controller when error is caught 
      nil
    end
  end

  def self.search_db(symbol)
    where(symbol: symbol).first
  end
end
