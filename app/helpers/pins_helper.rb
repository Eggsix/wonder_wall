module PinsHelper
	def image_collection
		image_url_array = Array.new
		self.all.each do |img| 
		  image_url_array << img.image.url
		end
		return image_url_array
	end
end
