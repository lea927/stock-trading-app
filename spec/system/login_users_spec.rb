require 'rails_helper'

RSpec.describe 'logging in users', type: :system do
  let(:admin_role) do 
      Role.find_or_create_by({name: 'Admin'})
  end
  let(:admin_user) do 
    User.create!(
      first_name: 'Bob', last_name: 'Marley', email: 'test@example.com', password: 'test123', role: 1
    )
  end

  it 'successfully signs in' do
    visit new_user_session_path
    login_as(admin_user)
    expect(page).to have_content("Signed in successfully.")
  end
  it 'should check if user is signed up with proper role' do
    expect(admin_user.role.name).to eq('Admin')
    expect(User.find(admin_user.id).role.name).to eq('Admin')
  end
end
