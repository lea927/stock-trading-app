require 'rails_helper'

RSpec.describe 'searching stocks', type: :system, driver: :selenium_chrome, js: true do
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

  describe 'searches correct stock symbol' do
    it 'visits search stock page' do
      login_broker
      expect(page).to have_css('input[type="text"]')
    end

    it "successfully displays stock's company name" do
      login_broker
      search_stock
      sleep(1)
      expect(page).to have_content 'Amazon.com Inc'
    end
  end

  describe 'searches incorrect stock symbol' do
    it 'displays alert message' do
      login_broker
      fill_in 'stock',	with: 'YO'
      page.find('button[type="submit"]').click
      sleep(1.2)
      expect(page).to have_content 'Please enter a valid stock symbol'
    end
  end
end
