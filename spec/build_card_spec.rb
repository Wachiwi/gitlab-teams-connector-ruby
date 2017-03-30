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
      expect(@c.title).to eq 'build Event'
      expect(@c.description).to eq 'A build for branch master in [gitlab-org/gitlab-test](http://192.168.64.1:3005/gitlab-org/gitlab-test) did successfully finish!<br/>The build took roughly 3min to finish'
    end
  end

end
