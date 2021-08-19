require 'rails_helper'

RSpec.describe 'editing users', type: :system, driver: :selenium_chrome, js: true do
  let(:reset_id) do
    Role.connection.execute('ALTER SEQUENCE roles_id_seq RESTART')
  end
  let(:role) do
    @role = FactoryBot.create(:role)
  end
  let(:user) do
    @user = FactoryBot.create(:user)
  end
  let(:broker) do
    @broker = User.create!(
      first_name: 'Jane',
      last_name: 'Doe',
      email: 'janedoe_broker@email.com',
      password: 'janedoe123',
      role_id: 2 )
  end
  let(:fillout_form) do
    page.select 'Broker', :from => 'user[role_id]'
    fill_in 'user_first_name', with: 'Jane Edited'
    fill_in 'user_last_name', with: 'Doe Edited'
    fill_in 'user_email', with: 'janedoe_broker_edited@email.com'
    fill_in 'user_password', with: 'janedoe123edited'
    fill_in 'user_password_confirmation', with: 'janedoe123edited'
  end
  before do
    reset_id
    role
    user
  end
  before :each do
    login_as(@user, :scope => :user)
  end
  describe 'edit a user' do
    it 'validates the path' do
      visit edit_users_admin_path(id: broker.id)
      expect(page).to have_current_path edit_users_admin_path(id: broker.id)
      sleep(2)
    end
    it 'fills out with complete details' do
      visit edit_users_admin_path(id: broker.id)
      fillout_form
      click_on 'Update User'
      sleep(2)
    end
  end
end
