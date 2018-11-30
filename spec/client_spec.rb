require_relative 'spec_helper'

RSpec.describe PayStand::Client do
  describe '#base_url' do
    let!(:default_env) { PayStand.config.env }
    before do
      PayStand::Client.instance_variable_set(:@base_url, nil)
    end

    context 'with default env' do
      it { expect(PayStand::Client.base_url).to eq "https://api.paystand.info/v3" }
    end

    context 'with production env' do
      before do
        PayStand.configure { |config| config.env = :production }
      end

      it { expect(PayStand::Client.base_url).to eq "https://api.paystand.com/v3" }
    end

    context 'with sandbox env' do
      before do
        PayStand.configure { |config| config.env = :sandbox }
      end

      it { expect(PayStand::Client.base_url).to eq "https://api.paystand.co/v3" }
    end

    after do
      PayStand.configure { |config| config.env = default_env }
    end
  end
end
