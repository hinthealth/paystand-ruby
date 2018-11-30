require_relative 'spec_helper'

RSpec.describe HashUtils do
  describe '.to_camelback_keys' do
    it 'transforms :home_description to homeDescription' do
      expected_hash = { homeDescription: 'my house' }
      expect(HashUtils.to_camelback_keys({ home_description: 'my house' })).to eq expected_hash
    end

    it "doesn't transform 'home_description'" do
      hash = { 'home_description' => 'my house' }
      expect(HashUtils.to_camelback_keys(hash)).to eq hash
    end
  end
end
