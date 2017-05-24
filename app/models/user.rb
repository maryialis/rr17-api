class User < ApplicationRecord
  validates :email, presence:true, uniqueness:true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :password, presence:true
  
  def full_name
    first_name + ' ' + last_name
  end
  
  before_save :prepare

  private
  def prepare
    email.downcase!
    if (!first_name && !last_name)
      self.first_name = (0...8).map { (65 + rand(26)).chr }.join
      self.last_name = (0...8).map { (65 + rand(26)).chr }.join
    end
    puts "First name: #{first_name} Last name: #{last_name}"
    if (first_name && last_name)
      first_name.capitalize!
      last_name.capitalize!
      true
    else
      false
    end
  end
end
