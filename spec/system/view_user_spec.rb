require 'rails_helper'

RSpec.describe 'viewing a user', type: :system do
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
    @broker = User.create!(email: 'janedoe_broker@email.com', password: 'janedoe123', role_id: 2, first_name: 'Jane', last_name: 'Doe', approved: true)
  end

  before do
    driven_by(:selenium_chrome_headless)
    reset_id
    role
    user
  end

  it "displays a user's full name" do
    login_as(user)
    visit users_admin_path(id: broker.id)
    expect(page).to have_content(broker.full_name)
  end

  it "displays a user's email" do
    login_as(user)
    visit users_admin_path(id: broker.id)
    expect(page).to have_content(broker.email)
  end

  it "displays a user's role" do
    login_as(user)
    visit users_admin_path(id: broker.id)
    expect(page).to have_content(broker.role.name)
  end
end
