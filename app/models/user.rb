class User < ActiveRecord::Base
  has_many :outlines, dependent: :destroy

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  
  has_secure_password
  #this is a method reference. Rails will look for a method of this name and run it before saving a user.

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :password, length: { minimum: 6 }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, 
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end