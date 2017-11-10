class DataController < ActionController::Base

	def create
		render plain: 'Create OK', layout: false, status: 200

		property_names = [ 'device_name', 'device_id', 'logged_at', 'time_delta', 'date', 'time', 'acceleration_xaxis', 'acceleration_yaxis', 'acceleration_zaxis', 'angular_velocity_xaxis', 'angular_velocity_yaxis', 'angular_velocity_zaxis', 'angle_xaxis', 'angle_yaxis', 'angle_zaxis' ]

		data_points_attributes = params[:_json]
		data_points_attributes ||= [ params ]


		DataPoint.bulk_insert do |worker|
			data_points_attributes.each do |data_point_attributes|
				attrs = {}

				attrs[:raw_data] = data_point_attributes.to_json

				property_names.each do |property_name|
					attrs[property_name.to_sym] = data_point_attributes[property_name]
				end

				attrs[:logged_at] = attrs[:logged_at] || Time.at( data_point_attributes[:timestamp].to_f / 1000 ) if data_point_attributes[:timestamp].present?

				worker.add(attrs)
			end
		end

	end

	def index
		@limit = params[:limit] || 500

		# last_data_point = DataPoint.last
		# @seconds_per_datapoint = 6
		# @seconds_per_datapoint = ( 60.0 / DataPoint.where( created_at: last_data_point.created_at - 1.minute..last_data_point.created_at ).count ).round if last_data_point.present?

		@data_points = DataPoint.all
		@data_points = @data_points.with_all_tags( params[:tags] ) if params[:tags].present?
		@data_points = @data_points.where( tags: '{}' ) if params[:no_tags].present?


		last_index = params[:since] || @data_points.order(id: :desc).offset(@limit).pluck(:id).first || 0

		@data_points = @data_points.where( 'id > ?', last_index )
		@data_points = @data_points.order( id: :asc ).limit(@limit)

		render layout: false, status: 200

	end

	def twod

		render layout: false

	end

end
