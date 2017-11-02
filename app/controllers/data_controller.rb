class DataController < ActionController::Base

	def create
		render :text => 'Create OK', layout: false, status: 200
		puts "request.raw_post"
		puts request.raw_post
	end

	def index
		render :text => 'Index OK', layout: false, status: 200
	end

end
