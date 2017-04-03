require_relative 'card'

module MSTeams

  class PushCard < Card

    def initialize(payload)
      super payload
      parse_payload payload
      generate_description
    end

    private

    def parse_payload(payload)
      @branch = payload['ref'][11..-1]
      @commits_count = payload['total_commits_count']
      @latest_commit_id = payload['after']
      @latest_commit_url = payload['commits'][0]['url']
    end

    def generate_description
      @description = "#{@author} pushed #{commit_phrase} ([#{@latest_commit_id}](#{@latest_commit_url})) "\
              "to branch #{@branch} in [#{@project_name}](#{@project_url})"
    end

    def commit_phrase
      if @commits_count != 1
        "#{@commits_count} commits"
      else
        "#{@commits_count} commit"
      end
    end

  end
end
