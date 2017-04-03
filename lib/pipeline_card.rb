require_relative 'card'

module MSTeams

  class PipelineCard < Card

    def initialize(payload)
      super payload
      parse_payload payload
      generate_description
    end

    private

    def parse_payload(payload)
      @action = payload['object_attributes']['status']
      @pipeline_branch = payload['object_attributes']['ref']
      @pipeline_duration = payload['object_attributes']['duration']
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
      @description = "A Pipeline for branch #{@pipeline_branch} in [#{@project_name}](#{@project_url}) #{action_phrase}!<br/>"
      @description += "The Pipeline took roughly #{@pipeline_duration % 60}min to finish" if @action == 'created' or @action == 'success'
    end
  end
end
