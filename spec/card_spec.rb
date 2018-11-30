require_relative 'spec_helper'

RSpec.describe PayStand::Card, mock_paystand: true do
  let(:customer_id) { PayStand.config.platform_customer_id }
  subject { PayStand::Card }

  describe '.retrieve' do
    let(:card) { subject.retrieve('12345') }

    it 'returns a card object with data' do
      expect(card.name_on_card).to eq 'John Doe'
      expect(card.security_code).to eq '123'
      expect(card.expiration_year.to_i).to eq Date.today.strftime('%Y').to_i + 1
    end
  end

  describe '.update' do
    let(:card) { subject.update('12345', { security_code: '700' }) }

    it 'returns a card object with data updated' do
      expect(card.name_on_card).to eq 'John Doe'
      expect(card.security_code).to eq '700'
    end
  end
end
