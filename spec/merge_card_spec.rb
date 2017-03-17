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
      expect(@c).not_to respond_to('commit_phraase')
    end

    it 'should not allow to access private attributes' do
      expect(@c).not_to respond_to('author')
      expect(@c).not_to respond_to('project_name')
      expect(@c).not_to respond_to('project_url')
      expect(@c).not_to respond_to('branch')
      expect(@c).not_to respond_to('commits_count')
      expect(@c).not_to respond_to('latest_commit_id')
      expect(@c).not_to respond_to('latest_commit_url')
    end
  end

  context 'given a valid payload' do
    it 'should have the correct title and description' do
      expect(@c.title).to eq 'Merge-Request Event'
    end

  end

end
