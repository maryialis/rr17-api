class SourceProvider < ApplicationRecord
  alias_attribute :author, :user_id
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  has_many :course_results, dependent: :destroy
  validates :name, :url, :address, presence: true
  validates :name, :url, uniqueness: true
end
