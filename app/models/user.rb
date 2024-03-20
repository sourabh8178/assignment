class User < ApplicationRecord
	require 'bcrypt'

	validates :email, presence: true, uniqueness: true #for email uniqness
	validates :password, presence: true  #for password must present
	validates_length_of :password, :minimum => 8 #lenght of the password
  has_many :blogs
  has_one :profile
  has_many :likes
  has_many :bookmarks
  has_many :follows
	before_save :encrypt_password

	before_save :ensure_authentication_token
   def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private
  def generate_authentication_token
   loop do
     token = SecureRandom.hex(20) #generate token for user
     break token unless User.find_by(authentication_token: token)
   end
  end

	def encrypt_password
		self.password = BCrypt::Password.create(self.password)
	end
end
