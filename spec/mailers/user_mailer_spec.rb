require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  include ActiveJob::TestHelper
  describe 'sending welcome email' do
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

    context 'when sending welcome email' do
      let(:mail) do
        ActionMailer::Base.deliveries.last
      end

      before do
        described_class.with(user: buyer).welcome_email.deliver_now
      end

      it 'increases delivered mail count' do
        expect { described_class.with(user: buyer).welcome_email.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'send mail with subject' do
        expect(mail.subject).to eq 'Welcome to Stockit'
      end

      it 'sends from correct email' do
        expect(mail.from).to include 'reidt2579@gmail.com'
      end

      it 'sents to correct email' do
        expect(mail.to).to include 'johndoe_buyer@email.com'
      end
    end
  end
end
