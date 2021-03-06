require 'rails_helper'

RSpec.describe 'creating users', type: :system do
  let(:reset_id) do
    Role.connection.execute('ALTER SEQUENCE roles_id_seq RESTART')
  end
  let(:role) do
    @role = FactoryBot.create(:role)
  end
  let(:fillout_broker) do
    page.select 'Broker', from: 'user[role_id]'
    fill_in 'user_first_name', with: 'Jane'
    fill_in 'user_last_name', with: 'Doe'
    fill_in 'user_email', with: 'janedoe_broker@email.com'
    fill_in 'user_password', with: 'janedoe123'
    fill_in 'user_password_confirmation', with: 'janedoe123'
  end
  let(:fillout_buyer) do
    page.select 'Buyer', from: 'user[role_id]'
    fill_in 'user_first_name', with: 'John'
    fill_in 'user_last_name', with: 'Doe'
    fill_in 'user_email', with: 'johndoe_buyer@email.com'
    fill_in 'user_password', with: 'johndoe123'
    fill_in 'user_password_confirmation', with: 'johndoe123'
  end

  before do
    driven_by(:selenium_chrome_headless)
    reset_id
    role
    user = User.create!(
      first_name: 'Tom',
      last_name: 'Reid',
      email: 'tom_admin@email.com',
      password: 'tom_admin123',
      role_id: 1
    )
    login_as(user, scope: :user)
  end

  it 'validates path if correct' do
    visit '/admin/users_admin/new'
    expect(page).to have_current_path new_users_admin_path
  end

  describe 'creates a broker user' do
    it 'fills out create form' do
      visit '/admin/users_admin/new'
      fillout_broker
      click_on 'Create User'
    end

    it 'validates if saved in database' do
      User.create!(email: 'janedoe_broker@email.com', password: 'janedoe123', role_id: 2, first_name: 'Jane', last_name: 'Doe')
      user = User.find_by(email: 'janedoe_broker@email.com')
      expect(user).not_to eq nil
    end
  end

  describe 'creates a buyer user' do
    it 'fills out create form' do
      visit '/admin/users_admin/new'
      fillout_buyer
      click_on 'Create User'
    end

    it 'validates if saved in database' do
      User.create!(email: 'johndoe_buyer@email.com', password: 'johndoe123', role_id: 3, first_name: 'John', last_name: 'Doe')
      user = User.find_by(email: 'johndoe_buyer@email.com')
      expect(user).not_to eq nil
    end
  end
end
