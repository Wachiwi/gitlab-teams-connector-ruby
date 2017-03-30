require 'json'

module MSTeams

  class Card
    attr_reader :title, :description

    def initialize payload, actionable=false
      @actionable = actionable
      parse_basic_information payload
      guess_title payload['object_kind'] rescue nil
    end

    # ToDo: Is this method necessary for later usage or only for specs?
    def to_hash
      hash = {}
      instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
      hash
    end

    def to_teams
       teams = { title: @title, description: @description }
       teams[:potentialAction] = [{
         '@context': 'https://schema.org',
         '@type': 'ViewAction',
         'name': @action_title,
         'target': [@action_url]
       }] if @actionable
       teams
    end

    private

    # ToDo: Cleanup this mess
    def parse_basic_information payload
      @author = payload['user_name'] || payload['user']['name'] rescue nil
      @project_name = payload['project']['path_with_namespace'] rescue payload['object_attributes']['target']['path_with_namespace'] rescue nil
      @project_url  = payload['project']['web_url'] rescue payload['object_attributes']['target']['web_url'] rescue nil
      @action_url = payload['object_attributes']['url'] if @actionable
    end

    def guess_title event
      # ToDo: Reduce complexity & unnecessary steps
      title = event.split(/ |\_/).map(&:capitalize).join('-')
      title = 'Comment' if title.eql? 'Note'
      @title = "#{title} Event"
      @action_title = "View #{title}" if @actionable
    end
  end

  def MSTeams.get_card_of_payload(payload)
    raise ArgumentError.new 'The payload must not be nil!' if payload.nil?

    case payload['object_kind']
    when 'push' then PushCard.new payload
    when 'merge_request' then MergeCard.new payload
    when 'issue' then IssueCard.new payload
    when 'pipeline' then # PipelineCard.new payload # unimplemented
    when 'build' then # BuildCard.new payload # unimplemented
    when 'note' then # CommentCard.get payload # unimplemented
    else nil
    end
  end
end
