class SourceParser < ApplicationRecord
  validates :parser_name, :url_pattern, presence: true
  
  def self.parse_source_provider(source_provider)
    parser = instantiate_parser(source_provider)
    if parser
      parse_and_process(parser, source_provider)
    else
      raise "Appropriate parser not found"
    end
  end
  
  private
  
  def self.source_parser_by_source_provider (source_provider)
    p = SourceParser.all.detect {|parser| source_provider.url =~ /#{parser.url_pattern}/i}
    p.try(:parser_name)
  end
  
  def self.instantiate_parser(source_provider)
    sp = SourceParser.source_parser_by_source_provider(source_provider)
    parser_class = "Parser::#{sp}".constantize rescue nil if sp
    if (parser_class)
      parser_class.new
    else
      nil
    end
  end
  
  def self.parse_and_process(parser, source_provider)
      result = parser.parse(File.open('/home/masha/RoR/rr17-api/test/belarusbank.html', encoding: 'windows-1251:utf-8').read).as_json
      if result["parsed"]
        cr = CourseResult.new(result['result']);
        cr[:source_provider_id] = source_provider.id
        cr.save!
        result
      else
        raise result['error']
      end
    end
end
