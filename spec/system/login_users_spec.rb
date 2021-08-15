require 'rails_helper'

RSpec.describe 'logging in users', type: :system do
  let(:role) do
    @role = FactoryBot.create(:role)
  end
  let(:user) do
    @user = FactoryBot.create(:user)
  end

  
  before do
    driven_by(:rack_test)
    role
    user
    visit new_user_session_path
  end

  it 'validates visited path' do
    expect(page).to have_current_path new_user_session_path
  end
end
