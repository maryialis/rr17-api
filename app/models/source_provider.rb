class SourceProvider < ApplicationRecord
  validates :name, :url, :address, presence: true
  validates :name, :url, uniqueness: true
end
