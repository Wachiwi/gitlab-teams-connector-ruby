require_relative 'card'

module MSTeams

  class MergeCard < Card

    def initialize(payload)
      super payload, true
      parse_payload payload
      generate_description
    end

    private

    def parse_payload(payload)
      @action = payload['object_attributes']['action']
      @mr_title = payload['object_attributes']['title']
      @mr_desc = payload['object_attributes']['description']
    end

    def action_phrase
      case @action
      when 'update' then 'updated'
      when 'create' then 'created'
      when 'close' then 'closed'
      when 'merge' then 'merged'
      when 'reopen' then 'reopened'
      else 'modified'
      end
    end

    def generate_description
      @description = "#{@author} #{action_phrase} a Merge Request in [#{@project_name}](#{@project_url})<br/>"\
        "*#{@mr_title}*<br/>#{@mr_desc.slice 0, 160}"
    end
  end
end
