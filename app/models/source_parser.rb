class SourceParser < ApplicationRecord
  validates :parser_name, :url_pattern, presence: true

  def self.parse_source_provider(source_provider)
    parser = instantiate_parser(source_provider)
    raise raise 'Appropriate parser not found' unless parser
    parse_and_process(parser, source_provider)
  end

  class << self
    private def source_parser_by_source_provider(source_provider)
      p = SourceParser.all.detect { |parser| source_provider.url =~ /#{parser.url_pattern}/i }
      p.try(:parser_name)
    end

    private def instantiate_parser(source_provider)
      sp = source_parser_by_source_provider(source_provider)
      return nil unless sp
      parser_class = "Parser::#{sp}".constantize rescue nil
      if parser_class
        parser_class.new
      else
        nil
      end
    end

    private def parse_and_process(parser, source_provider)
      result = parser.parse(File.open('/home/masha/RoR/rr17-api/test/belarusbank.html', encoding: 'windows-1251:utf-8').read).as_json
      raise result['error'] unless result['parsed']
      cr = CourseResult.new(result['result'])
      cr[:source_provider_id] = source_provider.id
      cr.save!
      result
    end
  end
end
