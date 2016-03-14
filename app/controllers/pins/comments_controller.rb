class Pins::CommentsController < CommentsController
	
	before_action :set_commentable

	private

	def set_commentable
		@commentable = Pin.find(params[:pin_id])
	end
end