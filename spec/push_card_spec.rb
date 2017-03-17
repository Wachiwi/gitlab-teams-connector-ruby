require 'spec_helper'
require_relative '../lib/push_card'

describe MSTeams::PushCard do
  before :context do
    @valid_push_payload = load_json_fixture :push
    @pc = MSTeams::PushCard.new @valid_push_payload
  end

  context 'visibility checks' do
    it 'should not respond to private methods' do
      expect(@pc).not_to respond_to('parse_payload')
      expect(@pc).not_to respond_to('generate_description')
      expect(@pc).not_to respond_to('commit_phraase')
    end

    it 'should not allow to access private attributes' do
      expect(@pc).not_to respond_to('author')
      expect(@pc).not_to respond_to('project_name')
      expect(@pc).not_to respond_to('project_url')
      expect(@pc).not_to respond_to('branch')
      expect(@pc).not_to respond_to('commits_count')
      expect(@pc).not_to respond_to('latest_commit_id')
      expect(@pc).not_to respond_to('latest_commit_url')
    end
  end

  context 'given a valid payload' do
    it 'should have the correct title and description' do
      expect(@pc.title).to eq 'Push Event'
      expect(@pc.description).to eq 'John Smith pushed 4 commits '\
        '([da1560886d4f094c3e6c9ef40349f7d38b5d27d7](http://example.com/mike'\
        '/diaspora/commit/b6568db1bc1dcd7f8b4d5a946b0b91f9dacd7327)) '\
        'to branch m in [mike/diaspora](http://example.com/mike/diaspora)'
    end

  end

end
