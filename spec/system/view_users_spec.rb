require 'rails_helper'

RSpec.describe 'viewing all users', type: :system, driver: :selenium_chrome, js: true do
  let(:reset_id) do
    Role.connection.execute('ALTER SEQUENCE roles_id_seq RESTART')
  end

  let(:role) do
    %w[Admin Broker Buyer].each do |role|
      Role.find_or_create_by({ name: role })
    end
  end
  let(:admin) do
    User.create!(
      first_name: 'Tom',
      last_name: 'Reid',
      email: 'tom_admin@email.com',
      password: 'tom_admin123',
      role_id: 1
    )
  end

  before do
    reset_id
    role
    admin
  end

  describe 'display approved users' do
    it 'displays registered brokers' do
      broker = User.create!(email: 'janedoe_broker@email.com', password: 'janedoe123', role_id: 2, first_name: 'Jane', last_name: 'Doe', approved: true)
      login_as(admin)
      visit '/admin/users_admin'
      sleep(1)
      expect(page).to have_content(broker.email)
    end

    it 'displays registered buyers' do
      buyer = User.create!(email: 'johndoe_buyer@email.com', password: 'johndoe123', role_id: 3, first_name: 'John', last_name: 'Doe')
      login_as(admin)
      visit '/admin/users_admin'
      sleep(1)
      expect(page).to have_content(buyer.email)
    end
  end

  describe 'display pending users' do
    it 'displays pending brokers' do
      broker = User.create!(email: 'janedoe_broker@email.com', password: 'janedoe123', role_id: 2, first_name: 'Jane', last_name: 'Doe')
      login_as(admin)
      visit '/admin/pending_brokers'
      sleep(1)
      expect(page).to have_content(broker.email)
    end
  end
end
