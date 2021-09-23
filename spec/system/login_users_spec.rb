require 'rails_helper'

RSpec.describe 'logging in users', type: :system, driver: :selenium_chrome, js: true do
  let(:reset_id) do
    Role.connection.execute('ALTER SEQUENCE roles_id_seq RESTART')
  end
  let(:user) do
    @role = FactoryBot.create(:role)
    @user = FactoryBot.create(:user)
  end

  before do
    reset_id
    user
  end

  it 'validates sign in path' do
    visit new_user_session_path
    expect(page).to have_current_path new_user_session_path
  end

  it 'successfully signs in' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end
end
