require 'chronic_duration'
require_relative 'card'

module MSTeams

  class BuildCard < Card

    def initialize(payload)
      super payload
      parse_payload payload
      generate_description
    end

    private

    def parse_payload(payload)
      @project_name = payload['project_name']
      @action = payload['build_status']
      @build_branch = payload['ref']
      @build_stage = payload['build_stage']
      @build_name = payload['build_name']
      @build_duration = payload['build_duration']
    end

    def action_phrase
      case @action
      when 'created' then 'was started'
      when 'success' then 'did successfully finish'
      when 'failed' then 'failed'
      when 'cancelled' then 'was cancelled'
      else 'has an unknown state'
      end
    end

    def generate_description
      @description = "The build for #{@build_stage}/#{@build_name} for branch #{@build_branch} in #{@project_name} #{action_phrase}!<br/>"
      @description += "The build took roughly #{ChronicDuration.output(@build_duration, :format => :short)} min to finish." if @action == 'success' or @action == 'failed'
    end
  end
end
