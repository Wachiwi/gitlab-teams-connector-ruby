require 'spec_helper'
require_relative '../lib/card'
require_relative '../lib/push_card'
require_relative '../lib/merge_card'

describe MSTeams::Card do
  context 'as an general instance' do
    before :context do
      @card = MSTeams::Card.new nil
    end

    it 'should fall back to nil based attributes if wrong parameters where provided' do
      expect(@card.title).to eq nil
      expect(@card.description).to eq nil
    end

    it 'should not allow direct acces to private attributes' do
      expect(@card).not_to respond_to('author')
      expect(@card).not_to respond_to('project_name')
      expect(@card).not_to respond_to('project_url')
    end
  end

  context 'in the static context `get_card_of_payload`' do
    it 'should raise an error when no payload is given' do
      expect{MSTeams::get_card_of_payload nil}.to raise_error ArgumentError
    end

    context 'simple event type' do
      before :context do
        @payload = load_json_fixture :push
      end

      it 'should detect an push event with a given push event' do
        expect(MSTeams::get_card_of_payload @payload).to be_instance_of MSTeams::PushCard
      end

      it 'should provide a teams object hash without an action item' do
        c = MSTeams::get_card_of_payload @payload
        expected_hash = {
          title: "Push Event",
          description: "John Smith pushed 4 commits ([da1560886d4f094c3e6c9ef40349f7d38b5d27d7](http://example.com/mike/diaspora/commit/b6568db1bc1dcd7f8b4d5a946b0b91f9dacd7327)) to branch master in [mike/diaspora](http://example.com/mike/diaspora)"
        }
        expect(c.to_teams).to eq expected_hash
      end
    end

    context 'actionable event type' do
      before :context do
        @payload = load_json_fixture :mr
      end
      it 'should provide a teams object hash with an action item' do
        c = MSTeams::get_card_of_payload @payload
        expected_hash = {
          title: 'Merge-Request Event',
          description: 'Administrator modified a Merge Request in [awesome_space/awesome_project](http://example.com/awesome_space/awesome_project)<br/>*MS-Viewport*<br/>',
          'potentialAction':  [{
            '@context': 'https://schema.org',
            '@type': 'ViewAction',
            'name': 'View Merge-Request',
            'target': ['http://example.com/diaspora/merge_requests/1']
          }]
        }
        expect(c.to_teams).to eq expected_hash
      end
    end
  end
end

