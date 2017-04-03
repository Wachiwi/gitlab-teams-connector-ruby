require 'spec_helper'
require_relative '../lib/build_card'

describe MSTeams::BuildCard do
  before :context do
    @valid_build_payload = load_json_fixture :build
    @c = MSTeams::BuildCard.new @valid_build_payload
  end

  context 'visibility checks' do
    it 'should not respond to private methods' do
      expect(@c).not_to respond_to('parse_payload')
      expect(@c).not_to respond_to('generate_description')
      expect(@c).not_to respond_to('action_phrase')
    end

    it 'should not allow to access private attributes' do
      expect(@c).not_to respond_to('build_branch')
      expect(@c).not_to respond_to('build_duration')
      expect(@c).not_to respond_to('action')
    end
  end

  context 'given a valid payload' do
    it 'should have an author and a project properties' do
      expect(@c.to_hash['author']).to eq @valid_build_payload['user']['name']
    end

    it 'should have the correct title and description' do
      expect(@c.title).to eq 'Build Event'
      expect(@c.description).to eq 'The build for test/test for branch gitlab-script-trigger in gitlab-org/gitlab-test was started!<br/>'
    end
  end

end
