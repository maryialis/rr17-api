class SourceProvider < ApplicationRecord
  alias_attribute :author, :user_id
  has_one :author, class_name: 'User', foreign_key: "user_id"
  has_many :course_results, dependent: :destroy
  validates :name, :url, :address, presence: true
  validates :name, :url, uniqueness: true
  
  def as_json(options = {})
    options[:methods] ||= []
    options[:methods] += [:author]
    super#(options.merge({ except: [:user_id] }))
  end
end
