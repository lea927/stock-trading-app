require 'rails_helper'

RSpec.describe "users controller", type: :request do
  let(:reset_id) do
    Role.connection.execute('ALTER SEQUENCE roles_id_seq RESTART')
  end
  let(:create_roles) do
    ['Admin', 'Broker', 'Buyer'].each do |role|
      Role.find_or_create_by({name: role})
    end
  end
  let(:create_admin) do
    @user = FactoryBot.create(:user)
  end
  let(:create_user) do
    User.create!(email:'janedoe_broker@email.com',password:'janedoe123',role_id: 2, first_name:'Jane',last_name:'Doe')
  end
  let(:prepare_database) do
    create_roles
    create_admin
    create_user
  end
  before do
    reset_id
    prepare_database
  end
  before :each do
    login_as(@user, :scope => :user)
  end
  describe "what happens on index" do
    it "requests all list of users" do
      get users_admin_index_path
      expect(response).to be_successful
      expect(response.body).to include('janedoe_broker@email.com')
    end
  end
end
