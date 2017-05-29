class User < ApplicationRecord
  REASONABLE_PASSWORD_LIMIT = (6..100)
  validates :email, presence:true, uniqueness:{case_sensitive: false}, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :password, presence:true, length: {in: REASONABLE_PASSWORD_LIMIT}
  validate :prepare_names
  
  def full_name
    first_name + ' ' + last_name
  end
  
  before_save :prepare

  private
  
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
