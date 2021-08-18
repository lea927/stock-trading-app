require 'rails_helper'

RSpec.describe 'User signing up', type: :system, driver: :selenium_chrome, js: true do
  let(:reset_id) do
    Role.connection.execute('ALTER SEQUENCE roles_id_seq RESTART')
  end
  let(:user) do
    @user = FactoryBot.create(:user)
  end
  let(:populate_form) do
    fill_in 'user_first_name', with: user.first_name
    fill_in 'user_last_name', with: user.last_name
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password_confirmation
    User.destroy_all
  end

  before do
    reset_id
    user
  end

  describe 'Successful sign up' do
    it 'signs up as a broker' do
      visit new_user_registration_path
      choose(option: 2)
      populate_form
      click_on 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end

    it 'signs up as a buyer' do
      visit new_user_registration_path
      choose(option: 3)
      populate_form
      click_on 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end
end
