class SourceParser < ApplicationRecord
  validates :parser_name, :url_pattern, presence: true
  
  def self.source_parser_from_source_provider (source_provider)
    p = SourceParser.all.detect {|parser| source_provider.url =~ /#{parser.url_pattern}/i}
    p.try(:parser_name)
  end
end
