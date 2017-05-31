class SourceParser < ApplicationRecord
  validates :parser_name, :url_pattern, presence: true
end
