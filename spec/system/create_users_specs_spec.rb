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
  let(:user) do
    @user = User.create!(
      first_name: 'Tom',
      last_name: 'Reid',
      email: 'tom_admin@email.com',
      password: 'tom_admin123',
      role_id: 1 )
  end
  before do
    reset_id
    role
    user
  end
  before :each do
    login_as(@user, :scope => :user)
  end
  it 'validates path if correct' do
    visit '/admin/users_admin/new'
    expect(page).to have_current_path new_users_admin_path
    sleep(2)
  end
end
