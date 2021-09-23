require 'rails_helper'

RSpec.describe 'viewing portfolio', type: :system do
  let(:reset_id) do
    Role.connection.execute('ALTER SEQUENCE roles_id_seq RESTART')
  end

  let(:role) do
    %w[Admin Broker Buyer].each do |role|
      Role.find_or_create_by({ name: role })
    end
  end

  before do
    driven_by(:selenium_chrome_headless)
    reset_id
    role
  end

  describe 'displays portfolio page' do
    it "displays broker's portfolio" do
      broker = User.create!(email: 'janedoe_broker@email.com', password: 'janedoe123', role_id: 2, first_name: 'Jane', last_name: 'Doe', approved: true)
      login_as(broker)
      visit '/my_portfolio/'
      expect(page).to have_content(/portfolio/i)
    end
  end
end
