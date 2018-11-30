require_relative 'spec_helper'

RSpec.describe PayStand::Bank, mock_paystand: true do
  let(:customer_id) { PayStand.config.platform_customer_id }
  subject { PayStand::Bank }
  let(:created_bank) { subject.create(name_on_account: 'John Doe') }

  describe '.create' do
    it 'returns a bank object with data' do
      expect(created_bank.name_on_account).to eq 'John Doe'
    end
  end

  describe '.retrieve' do
    let(:bank_id) { created_bank.id }
    let(:bank) { subject.retrieve(bank_id) }

    it 'returns a bank object with data' do
      expect(bank.name_on_account).to eq 'John Doe'
    end
  end

  describe '.update' do
    let(:bank_id) { created_bank.id }
    let(:bank) { subject.update(bank_id, { name_on_account: 'Jane Doe' }) }

    it 'returns a bank object with data updated' do
      expect(bank.name_on_account).to eq 'Jane Doe'
    end
  end

  describe '#verify' do
    let(:bank_id) { created_bank.id }
    let(:bank) { subject.retrieve(bank_id) }

    context 'with the right amounts' do
      it 'can verify amounts' do
        expect(bank.verify(['32', '45']).name_on_account).to eq 'John Doe'
      end

      context 'cannot do twice' do
        before do
          bank.verify(['32', '45'])
        end

        it 'cannot verify amounts' do
          expect { bank.verify(['32', '45']) }.to raise_error PayStand::InvalidRequestError
        end
      end
    end

    context 'with the wrong amounts' do
      it 'cannot verify amounts' do
        expect { bank.verify(['20', '30']) }.to raise_error PayStand::InvalidRequestError
      end
    end
  end
end
