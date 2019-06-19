require_relative 'spec_helper'

RSpec.describe PayStand::Refund, mock_paystand: true do
  subject { PayStand::Refund }
  let(:created_payment) { PayStand::Payment.create({ amount: 20.00 }) }
  let(:created_refund) { created_payment.create_refund({ amount: 10.00 }) }

  describe '#create_recoup' do
    let(:created_recoup) { created_refund.create_recoup({ example_account_key: 8 }) }

    it 'returns a recoup object with data' do
      expect(created_recoup.refund_id).to eq created_refund.id
      expect(created_recoup.payment_id).to eq created_payment.id
      expect(created_recoup.currency).to eq 'USD'
    end
  end

  describe '.retrieve' do
    let(:refund_id) { created_refund.id }
    let(:refund) { subject.retrieve(refund_id) }

    it 'returns a refund object with data' do
      expect(refund.payment_id).to eq created_payment.id
      expect(refund.currency).to eq 'USD'
      expect(refund.status).to eq 'paid'
    end
  end
end
