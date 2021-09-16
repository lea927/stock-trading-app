require 'rails_helper'

RSpec.describe 'adding stocks to portfolio', type: :system, driver: :selenium_chrome, js: true do
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

  let(:search_stock) do
    fill_in 'stock',	with: 'AMZN'
    page.find('button[type="submit"]').click
  end

  before do
    reset_id
    create_roles
    broker
  end

  describe "adding stocks to broker's portfolio" do
    it 'successfully adds stock to portfolio' do
      login_broker
      search_stock
      sleep(1)
      click_on 'Add'
      expect(page).to have_content 'Amazon.com Inc'
    end
  end
end
