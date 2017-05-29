class User < ApplicationRecord
  REASONABLE_PASSWORD_LIMIT = (6..100)
  validates :email, presence:true, uniqueness:{case_sensitive: false}, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :password, presence:true, length: {in: REASONABLE_PASSWORD_LIMIT}
  validate :prepare_names
  has_many :source_providers
  
  before_destroy :deactivate_source_providers
  
  def full_name
    first_name + ' ' + last_name
  end
  
  before_save :prepare

  private
  
  def deactivate_source_providers
    SourceProvider.where(author: id).update_all('active = false, author = NULL')
  end
  
  def prepare_names
    if (!first_name.present? && !last_name.present?)
      self.first_name = (0...8).map { (65 + rand(26)).chr }.join
      self.last_name = (0...8).map { (65 + rand(26)).chr }.join
    end
    errors.add(:base, "first_name or last_name is not set") unless (first_name.present? && last_name.present?)
  end
  
  def prepare
    email.downcase!
    first_name.capitalize!
    last_name.capitalize!
  end
end
