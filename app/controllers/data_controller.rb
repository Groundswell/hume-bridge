class DataController < ActionController::Base

	def create
		render plain: 'Create OK', layout: false, status: 200

		property_names = [ 'device_name', 'date', 'time', 'acceleration_xaxis', 'acceleration_yaxis', 'acceleration_zaxis', 'angular_velocity_xaxis', 'angular_velocity_yaxis', 'angular_velocity_zaxis', 'angle_xaxis', 'angle_yaxis', 'angle_zaxis' ]

		puts "request.raw_post"
		puts request.raw_post


		data_point = DataPoint.new
		data_point.raw_data = request.raw_post
		property_names.each do |property_name|
			data_point[property_name] = params[property_name]
		end
		data_point.save

	end

	def index
		last_index = params[:since] || DataPoint.order(id: :desc).offset(500).pluck(:id).first || 0

		@data_points = DataPoint.where( 'id > ?', last_index ).order( id: :asc ).limit(500)

		render layout: false, status: 200

	end

end
