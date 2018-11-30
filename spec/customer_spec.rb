require_relative 'spec_helper'

RSpec.describe PayStand::Customer, mock_paystand: true do
  let(:customer_id) { PayStand.config.platform_customer_id }
  subject { PayStand::Customer }
  let(:created_customer) { subject.create(name: 'Example customer') }

  describe '.create' do
    it 'returns a customer object with data' do
      expect(created_customer.name).to eq 'Example customer'
    end
  end

  describe '.retrieve' do
    let(:customer_id) { created_customer.id }
    let(:customer) { subject.retrieve(customer_id) }

    it 'returns a customer object with data' do
      expect(created_customer.name).to eq 'Example customer'
      expect(customer.email).to eq 'example@example.com'
    end
  end

  describe '.update' do
    let(:customer_id) { created_customer.id }
    let(:customer) { subject.update(customer_id, { email: 'example@mydomain.com' }) }

    it 'returns a customer object with data updated' do
      expect(customer.email).to eq 'example@mydomain.com'
    end
  end
end
