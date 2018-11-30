require_relative 'spec_helper'

RSpec.describe PayStand::Request do
  let(:base_url) { PayStand::Client.base_url }
  let(:request) { PayStand::Request.new customer_id: PayStand.config.platform_customer_id }

  before do
    stub_request(:post, "#{base_url}/oauth/token")
      .to_return(body: { access_token: 1234, token_type: 'Bearer' }.to_json)
    stub_request(:get, "#{base_url}/balances/summary")
      .to_return(body: { 'object' => 'balance' }.to_json)
  end

  describe '.initialize' do
    let(:path) { "#{base_url}/oauth/token" }

    it 'retrieves an access token' do
      request
      assert_requested :post, "#{base_url}/oauth/token"
      expect(request.instance_variable_get('@access_token')).to_not be_nil
    end
  end

  describe '#get' do
    let(:get_request) { request.get(path: 'balances/summary') }
    context 'with the right path' do
      it 'returns a response object' do
        get_request
        assert_requested :get, "#{base_url}/balances/summary"
        expect(get_request.class).to eq PayStand::Balance
      end
    end

    context 'with the wrong path' do
      let(:get_request) { request.get(path: 'balances/samurai') }

      before do
        error_response = OpenStruct.new(status: 404, body: {})
        allow(PayStand::Client).to receive(:execute_request).and_return(error_response)
      end

      it 'raises an error' do
        expect { get_request }.to raise_error PayStand::InvalidRequestError
      end
    end

    context 'with bad credentials' do
      before do
        error_response = OpenStruct.new(status: 401, body: {})
        allow(PayStand::Client).to receive(:execute_request).and_return(error_response)
      end

      it 'raises an error' do
        expect { get_request }.to raise_error PayStand::AuthenticationError
      end
    end

    context 'with a timeout' do
      before do
        WebMock.stub_request(:get, "#{base_url}/balances/summary").to_timeout
      end

      it 'raises an error' do
        request # requesting paystand access token with mock
        PayStand::Testing.disable do
          expect { get_request }.to raise_error PayStand::TimeoutError
        end
      end
    end

    context 'with a bad request' do
      let(:error_message) { 'Minimum payment amount requirement not met' }
      before do
        body = { 'error' => { 'details' => { 'explanation' => error_message } } }
        error_response = OpenStruct.new(status: 422, body: body)
        allow(PayStand::Client).to receive(:execute_request).and_return(error_response)
      end

      it 'raises an error' do
        expect { get_request }.to raise_error PayStand::InvalidRequestError, error_message
      end
    end

    context 'when there is an api error' do
      before do
        body = { 'error' => { 'details' => { 'code' => 'apiError' } } }
        error_response = OpenStruct.new(status: 400, body: body)
        allow(PayStand::Client).to receive(:execute_request).and_return(error_response)
      end

      it 'raises an error' do
        expect { get_request }.to raise_error PayStand::APIError
      end

      context 'without code' do
        before do
          error_response = OpenStruct.new(status: 400, body: {})
          allow(PayStand::Client).to receive(:execute_request).and_return(error_response)
        end

        it 'raises an error' do
          expect { get_request }.to raise_error PayStand::PayStandError
        end
      end
    end
  end
end
