require 'rails_helper'

RSpec.describe 'logging in users', type: :system, driver: :selenium_chrome, js: true do
  let(:role) do
    @role = FactoryBot.create(:role)
  end
  
  let(:user) do
    @user = FactoryBot.create(:user)
  end

  it 'validates sign in path' do
    visit new_user_session_path
    expect(page).to have_current_path new_user_session_path
    sleep(2)
  end

  it 'successfully signs in' do
    role && user
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_on 'Log in'
  end
end
