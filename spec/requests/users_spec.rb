require 'rails_helper'

RSpec.describe 'users controller', type: :request do
  let(:reset_id) do
    Role.connection.execute('ALTER SEQUENCE roles_id_seq RESTART')
  end
  let(:create_roles) do
    %w[Admin Broker Buyer].each do |role|
      Role.find_or_create_by({ name: role })
    end
  end
  let(:create_admin) do
    @user = FactoryBot.create(:user)
  end
  let(:create_user) do
    User.create!(email: 'janedoe_broker@email.com', password: 'janedoe123', role_id: 2, first_name: 'Jane', last_name: 'Doe', approved: true)
  end
  let(:login_user) do
    login_as(@user, scope: :user)
  end

  before do
    reset_id
    create_roles && create_admin && create_user
    login_user
  end

  describe 'index' do
    it 'requests all list of users' do
      get users_admin_index_path
      expect(response.body).to include('janedoe_broker@email.com')
    end

    it 'checks response' do
      get users_admin_index_path
      expect(response).to be_successful
    end
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get users_admin_index_path
      expect(response).to render_template('users/index')
    end

    it 'renders header layout' do
      get users_admin_index_path
      expect(response).to render_template('layouts/_header')
    end

    it 'renders the application layout' do
      get users_admin_index_path
      expect(response).to render_template('layouts/application')
    end

    it 'does not render a different template' do
      get users_admin_index_path
      expect(response).not_to render_template(:show)
    end
  end
end
