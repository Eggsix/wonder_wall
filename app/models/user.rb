class User < ActiveRecord::Base
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	has_many :comments, as: :commentable
	has_many :pins, dependent: :destroy
	has_attached_file :image, styles: { medium: "300x300>", thumb: "20x20>" }, default_url: "/images/:style/missing.png"
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	validates :first_name, :last_name, presence: true
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
	devise :database_authenticatable, :registerable,
	        :recoverable, :rememberable, :trackable, :validatable
	
	before_save do
  		self.email.downcase!
  	end

  	def full_name
  		[first_name, last_name].join(' ')
  	end
end
