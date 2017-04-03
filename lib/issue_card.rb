require_relative 'card'

module MSTeams

  class IssueCard < Card

    def initialize(payload)
      super payload, true
      parse_payload payload
      generate_description
    end

    private

    def parse_payload(payload)
      @action = payload['object_attributes']['action']
      @issue_nr = payload['object_attributes']['id']
      @issue_title = payload['object_attributes']['title']
      @issue_desc = payload['object_attributes']['description']
    end

    def action_phrase
      case @action
      when 'update' then 'updated'
      when 'create' then 'created'
      when 'close' then 'closed'
      when 'open' then 'opened'
      when 'reopen' then 'reopened'
      else 'modified'
      end
    end

    def generate_description
      @description = "#{@author} #{action_phrase} Issue ##{@issue_nr} in [#{@project_name}](#{@project_url})<br/>"\
        "*#{@issue_title}*<br/>#{@issue_desc.slice 0, 160}"
    end
  end
end
