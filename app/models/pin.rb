class Pin < ActiveRecord::Base
	belongs_to :user
	has_many :comments, as: :commentable
	has_attached_file :image, styles: { medium: "300x300>", thumb: "50x50>" }, default_url: "/images/:style/missing.png"
	validates :description, presence: true
	validates_attachment :image, presence: true, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end
