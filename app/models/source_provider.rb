class SourceProvider < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author
  has_many :course_results, dependent: :destroy
  validates :name, :url, :address, presence: true
  validates :name, :url, uniqueness: true
end
