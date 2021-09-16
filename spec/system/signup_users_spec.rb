require 'rails_helper'

RSpec.describe 'User signing up', type: :system, driver: :selenium_chrome, js: true do
  let(:reset_id) do
    Role.connection.execute('ALTER SEQUENCE roles_id_seq RESTART')
  end
  let(:user) do
    @role = FactoryBot.create(:role)
    @user = FactoryBot.create(:user)
  end
  let(:populate_form) do
    within 'form' do
      fill_in 'user_first_name', with: user.first_name
      fill_in 'user_last_name', with: user.last_name
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password_confirmation
      User.destroy_all
      click_on 'Sign up'
    end
  end

  before do
    reset_id
    user
    visit new_user_registration_path
  end

  describe 'Successful sign up' do
    it 'signs up as a buyer' do
      visit new_user_registration_path
      choose(option: 3)
      populate_form
      sleep(1)
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end

  describe 'Pending approval' do
    it 'signs up as a broker' do
      visit new_user_registration_path
      choose(option: 2)
      populate_form
      sleep(1)
      expect(page).to have_content('You have signed up successfully but your account has not been approved by your administrator yet')
    end
  end
end
