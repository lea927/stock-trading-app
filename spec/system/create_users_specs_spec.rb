require 'rails_helper'

RSpec.describe 'creating users', type: :system, driver: :selenium_chrome, js: true do
  let(:reset_id) do
    Role.connection.execute('ALTER SEQUENCE roles_id_seq RESTART')
  end
  let(:role) do
    ['Admin', 'Broker', 'Buyer'].each do |role|
        Role.find_or_create_by({name: role})
    end
  end
  let(:admin) do
    @user = User.create!(
      first_name: 'Tom',
      last_name: 'Reid',
      email: 'tom_admin@email.com',
      password: 'tom_admin123',
      role_id: 1 )
  end
  let(:fillout_broker) do
    page.select 'Broker', :from => 'user[role_id]'
    fill_in 'user_first_name', with: 'Jane'
    fill_in 'user_last_name', with: 'Doe'
    fill_in 'user_email', with: 'janedoe_broker@email.com'
    fill_in 'user_password', with: 'janedoe123'
    fill_in 'user_password_confirmation', with: 'janedoe123'
  end
  let(:fillout_buyer) do
    page.select 'Buyer', :from => 'user[role_id]'
    fill_in 'user_first_name', with: 'John'
    fill_in 'user_last_name', with: 'Doe'
    fill_in 'user_email', with: 'johndoe_buyer@email.com'
    fill_in 'user_password', with: 'johndoe123'
    fill_in 'user_password_confirmation', with: 'johndoe123'
  end
  before do
    reset_id
    role
    admin
  end
  before :each do
    login_as(@user, :scope => :user)
  end
  it 'validates path if correct' do
    visit '/admin/users_admin/new'
    expect(page).to have_current_path new_users_admin_path
    sleep(2)
  end
  it 'creates a broker user' do
    visit '/admin/users_admin/new'
    fillout_broker
    click_on 'Create User'
    sleep(2)
  end
  it 'creates a buyer user' do
    visit '/admin/users_admin/new'
    fillout_buyer
    click_on 'Create User'
    sleep(2)
  end
end
