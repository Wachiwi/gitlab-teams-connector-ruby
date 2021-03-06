require 'spec_helper'
require_relative '../lib/merge_card'

describe MSTeams::MergeCard do
  before :context do
    @valid_merge_payload = load_json_fixture :mr
    @c = MSTeams::MergeCard.new @valid_merge_payload
  end

  context 'visibility checks' do
    it 'should not respond to private methods' do
      expect(@c).not_to respond_to('parse_payload')
      expect(@c).not_to respond_to('generate_description')
      expect(@c).not_to respond_to('action_phrase')
    end

    it 'should not allow to access private attributes' do
      expect(@c).not_to respond_to('mr_title')
      expect(@c).not_to respond_to('mr_desc')
      expect(@c).not_to respond_to('action')
    end
  end

  context 'given a valid payload' do
    it 'should have an author and a project properties' do
      expect(@c.to_hash['author']).to eq @valid_merge_payload['user']['name']
    end

    it 'should have the correct title and description' do
      expect(@c.title).to eq 'Merge-Request Event'
    end

    it 'should have a action struct inside its hash' do
      action = @c.to_teams[:potentialAction]
      expect(action).not_to eq nil
      expect(action).to be_instance_of Array
      expect(action.size).to eq 1
      expect(action).to respond_to :[]
      expect(action[0][:name]).to eq 'View Merge-Request'
      expect(action[0][:target]).to be_instance_of Array
      expect(action[0][:target]).to respond_to :[]
      expect(action[0][:target].size).to eq 1
      expect(action[0][:target][0]).to eq @valid_merge_payload['object_attributes']['url']
    end
  end

end
