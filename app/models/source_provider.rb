class SourceProvider < ApplicationRecord
  has_many :course_results, dependent: :destroy
  validates :name, :url, :address, presence: true
  validates :name, :url, uniqueness: true
end
