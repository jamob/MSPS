class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :position, :full_name
  has_secure_password

  before_save do 
    if self.email.blank?
      self.email = "mcgill.physics@gmail.com"
    else
      self.email.downcase!
    end
  end
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :full_name, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
