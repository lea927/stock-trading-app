require 'rails_helper'

RSpec.describe 'adding stocks to portfolio', type: :system do
  let(:reset_id) do
    Role.connection.execute('ALTER SEQUENCE roles_id_seq RESTART')
  end

  let(:create_roles) do
    %w[Admin Broker Buyer].each do |role|
      Role.find_or_create_by({ name: role })
    end
  end
  let(:broker) do
    User.create!(email: 'janedoe_broker@email.com', password: 'janedoe123', role_id: 2, first_name: 'Jane', last_name: 'Doe', approved: true)
  end

  let(:login_broker) do
    login_as(broker)
    visit search_stock_path
  end

  let!(:stock) do
    Stock.create(symbol: 'AMZN', company_name: 'Amazon.com Inc.', price: 3380.05)
  end

  before do
    driven_by(:selenium_chrome_headless)
    reset_id
    create_roles && broker
    broker.stocks << stock
  end

  describe "adding stocks to broker's portfolio" do
    it 'successfully adds stock to portfolio' do
      expect(broker.stocks.last).to eq stock
    end
  end
end
