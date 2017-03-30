require 'spec_helper'
require_relative '../lib/issue_card'

describe MSTeams::IssueCard do
  before :context do
    @valid_issue_payload = load_json_fixture :issue
    @c = MSTeams::IssueCard.new @valid_issue_payload
  end

  context 'visibility checks' do
    it 'should not respond to private methods' do
      expect(@c).not_to respond_to('parse_payload')
      expect(@c).not_to respond_to('generate_description')
      expect(@c).not_to respond_to('action_phrase')
    end

    it 'should not allow to access private attributes' do
      expect(@c).not_to respond_to('issue_nr')
      expect(@c).not_to respond_to('issue_title')
      expect(@c).not_to respond_to('issue_desc')
      expect(@c).not_to respond_to('action')
    end
  end

  context 'given a valid payload' do
    it 'should have an author and a project properties' do
      expect(@c.to_hash['author']).to eq @valid_issue_payload['user']['name']
    end

    it 'should have the correct title and description' do
      expect(@c.title).to eq 'Issue Event'
    end

    it 'should have a action struct inside its hash' do
      action = @c.to_teams[:potentialAction]
      expect(action).not_to eq nil
      expect(action).to be_instance_of Array
      expect(action.size).to eq 1
      expect(action).to respond_to :[]
      expect(action[0][:name]).to eq 'View Issue'
      expect(action[0][:target]).to be_instance_of Array
      expect(action[0][:target]).to respond_to :[]
      expect(action[0][:target].size).to eq 1
      expect(action[0][:target][0]).to eq @valid_issue_payload['object_attributes']['url']
    end
  end

end
