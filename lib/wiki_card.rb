require_relative 'card'

module MSTeams

  class WikiCard < Card

    def initialize(payload)
      super payload, true
      parse_payload payload
      generate_description
    end

    private

    def parse_payload(payload)
      @action = payload['object_attributes']['action']
      @wiki_slug = payload['object_attributes']['slug']
      @wiki_title = payload['object_attributes']['title']
      @wiki_content = payload['object_attributes']['content']
    end

    def action_phrase
      case @action
      when 'update' then 'updated'
      when 'create' then 'created'
      when 'delete' then 'deleted'
      else 'modified'
      end
    end

    def generate_description
      @description = "#{@author} #{action_phrase} the wiki page `#{@wiki_slug}` in [#{@project_name}](#{@project_url})<br/>"\
        "*#{@wiki_title}*<br/>#{@wiki_content.slice 0, 160}"
    end
  end
end
