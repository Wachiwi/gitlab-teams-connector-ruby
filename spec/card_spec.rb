require 'spec_helper'
require_relative '../lib/card'
require_relative '../lib/push_card'

describe MSTeams::Card do
  context 'in the static context `get_card_of_payload`' do
    it 'should raise an error when no payload is given' do
      expect{MSTeams::get_card_of_payload nil}.to raise_error ArgumentError
    end

    it 'should detect an push event with a given push event' do
      payload = load_json_fixture :push
      expect(MSTeams::get_card_of_payload payload).to be_instance_of MSTeams::PushCard
    end
  end
end

