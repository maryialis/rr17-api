class CourseResult < ApplicationRecord
  belongs_to :source_provider
  validates :eur, :usd, :rur, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
