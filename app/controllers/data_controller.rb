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
		@limit = params[:limit] || 500

		last_index = params[:since] || DataPoint.order(id: :desc).offset(@limit).pluck(:id).first || 0

		# last_data_point = DataPoint.last
		# @seconds_per_datapoint = 6
		# @seconds_per_datapoint = ( 60.0 / DataPoint.where( created_at: last_data_point.created_at - 1.minute..last_data_point.created_at ).count ).round if last_data_point.present?

		@data_points = DataPoint.where( 'id > ?', last_index ).order( id: :asc ).limit(@limit)

		render layout: false, status: 200

	end

end
