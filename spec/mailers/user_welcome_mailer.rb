require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe UserMailer, :type => :mailer do
  describe "sending welcome email" do
    let(:reset_id) do
        Role.connection.execute('ALTER SEQUENCE roles_id_seq RESTART')
      end
      let(:role) do
        @role = FactoryBot.create(:role)
      end
      let(:buyer) do
        @buyer = User.create!(email: 'johndoe_buyer@email.com', password: 'johndoe123', role_id: 3, first_name: 'John', last_name: 'Doe')
      end
      before do
        reset_id
        role
        buyer
      end
    
    it "sends welcome email" do
        expect { UserMailer.welcome_email(buyer).deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
        mail = ActionMailer::Base.deliveries.last
        expect(mail.subject).to eq 'Welcome to Stockit'
        expect(mail.from).to include "tom.stockit@gmail.com"
        expect(mail.to).to include "johndoe_buyer@email.com"
      end
  end
end