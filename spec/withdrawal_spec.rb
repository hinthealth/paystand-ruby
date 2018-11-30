require_relative 'spec_helper'

RSpec.describe PayStand::Withdrawal, mock_paystand: true do
  let(:customer_id) { PayStand.config.platform_customer_id }
  subject { PayStand::Withdrawal }
  let(:created_withdrawal) { subject.create(customer_id, { amount: 20.00 }) }

  describe '.create' do
    it 'returns a withdrawal object with data' do
      expect(created_withdrawal.amount).to eq 20.00
      expect(created_withdrawal.currency).to eq 'USD'
      expect(created_withdrawal.status).to eq 'posted'
    end
  end

  describe '.retrieve' do
    let(:withdrawal_id) { created_withdrawal.id }
    let(:withdrawal) { subject.retrieve(customer_id, withdrawal_id) }

    it 'returns a withdrawal object with data' do
      expect(withdrawal.currency).to eq 'USD'
      expect(withdrawal.status).to eq 'posted'
    end
  end

  describe '.update' do
    let(:withdrawal) { subject.update(customer_id, created_withdrawal.id, { meta: { update: 'withdrawal' } }) }

    it 'returns a withdrawal object with data updated' do
      expect(withdrawal.meta.update).to eq 'withdrawal'
    end
  end

  describe '.settings' do
    let(:bank_id) { 'bk_12345' }
    let(:accounts) { { default: bank_id } }
    let(:configured_withdrawal) { subject.settings(customer_id, frequency: 'weekly', accounts: accounts) }

    it 'returns the withdrawal auto configuration' do
      expect(configured_withdrawal.auto.frequency).to eq 'weekly'
      expect(configured_withdrawal.auto.active).to match_array([:default])
      expect(configured_withdrawal.auto.accounts[:default]).to eq bank_id
    end
  end
end
