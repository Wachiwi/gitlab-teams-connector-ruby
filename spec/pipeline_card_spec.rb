require 'spec_helper'
require_relative '../lib/pipeline_card'

describe MSTeams::PipelineCard do
  before :context do
    @valid_pipeline_payload = load_json_fixture :pipeline
    @c = MSTeams::PipelineCard.new @valid_pipeline_payload
  end

  context 'visibility checks' do
    it 'should not respond to private methods' do
      expect(@c).not_to respond_to('parse_payload')
      expect(@c).not_to respond_to('generate_description')
      expect(@c).not_to respond_to('action_phrase')
    end

    it 'should not allow to access private attributes' do
      expect(@c).not_to respond_to('pipeline_branch')
      expect(@c).not_to respond_to('pipeline_duration')
      expect(@c).not_to respond_to('action')
    end
  end

  context 'given a valid payload' do
    it 'should have an author and a project properties' do
      expect(@c.to_hash['author']).to eq @valid_pipeline_payload['user']['name']
    end

    it 'should have the correct title and description' do
      expect(@c.title).to eq 'Pipeline Event'
      expect(@c.description).to eq 'A pipeline for branch master in [gitlab-org/gitlab-test](http://192.168.64.1:3005/gitlab-org/gitlab-test) did successfully finish!<br/>The pipeline took roughly 1m 3s to finish'
    end

    # Is not actionable so this example is not necessary
    # it 'should have a action struct inside its hash' do
    #   action = @c.to_teams[:potentialAction]
    #   expect(action).not_to eq nil
    #   expect(action).to be_instance_of Array
    #   expect(action.size).to eq 1
    #   expect(action).to respond_to :[]
    #   expect(action[0][:name]).to eq 'View Pipeline'
    #   expect(action[0][:target]).to be_instance_of Array
    #   expect(action[0][:target]).to respond_to :[]
    #   expect(action[0][:target].size).to eq 1
    #   expect(action[0][:target][0]).to eq @valid_pipeline_payload['object_attributes']['url']
    # end
  end

end
