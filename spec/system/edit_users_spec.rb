require 'rails_helper'

RSpec.describe 'editing users', type: :system do
  let(:reset_id) do
    Role.connection.execute('ALTER SEQUENCE roles_id_seq RESTART')
  end
  let(:role) do
    @role = FactoryBot.create(:role)
  end
  let(:login_admin) do
    user = FactoryBot.create(:user)
    login_as(user)
  end
  let(:broker) do
    @broker = User.create!(
      first_name: 'Jane',
      last_name: 'Doe',
      email: 'janedoe_broker@email.com',
      password: 'janedoe123',
      role_id: 2
    )
  end
  let(:fillout_form) do
    page.select 'Broker', from: 'user[role_id]'
    fill_in 'user_first_name', with: 'Jane Edited'
    fill_in 'user_last_name', with: 'Doe Edited'
    fill_in 'user_email', with: 'janedoe_broker_edited@email.com'
  end

  before do
    driven_by(:selenium_chrome_headless)
    reset_id
    role && broker && login_admin
  end

  describe 'editing a user' do
    before do
      visit edit_users_admin_path(id: broker.id)
    end

    it 'validates the path' do
      expect(page).to have_current_path edit_users_admin_path(id: broker.id)
    end

    it 'fills out with complete details' do
      fillout_form
      fill_in 'user_password', with: 'janedoe123edited'
      fill_in 'user_password_confirmation', with: 'janedoe123edited'
      click_on 'Update User'
      expect(page).to have_content 'User was successfully updated.'
    end

    it 'fills out without password' do
      fillout_form
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      click_on 'Update User'
      expect(page).to have_content 'User was successfully updated.'
    end
  end

  describe 'blank input fields' do
    before do
      visit edit_users_admin_path(id: broker.id)
      fill_in 'user_first_name', with: ''
      fill_in 'user_last_name', with: ''
      fill_in 'user_email', with: ''
      click_on 'Update User'
    end

    it 'displays email error' do
      expect(page).to have_content("Email can't be blank")
    end

    it 'displays first name error' do
      expect(page).to have_content("First name can't be blank")
    end

    it 'displays last name error' do
      expect(page).to have_content("Last name can't be blank")
    end
  end
end
