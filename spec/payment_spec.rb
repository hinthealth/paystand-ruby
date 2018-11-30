require_relative 'spec_helper'

RSpec.describe PayStand::Payment, mock_paystand: true do
  subject { PayStand::Payment }
  let(:created_payment) { subject.create({ amount: 20.00 }) }

  describe '.create' do
    it 'returns a payment object with data' do
      expect(created_payment.amount).to eq 20
      expect(created_payment.currency).to eq 'USD'
      expect(created_payment.status).to eq 'paid'
    end
  end

  describe '.retrieve' do
    let(:payment_id) { created_payment.id }
    let(:payment) { subject.retrieve(payment_id) }

    it 'returns a payment object with data' do
      expect(payment.currency).to eq 'USD'
      expect(payment.status).to eq 'paid'
    end
  end
end
