class CourseResult < ApplicationRecord
  validates :eur, :usd, :rur, presence:true, :numericality => true
end
