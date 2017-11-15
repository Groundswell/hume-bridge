last_data_point = nil

acceleration_xaxis_delta_sum = 0
acceleration_yaxis_delta_sum = 0
acceleration_zaxis_delta_sum = 0

last_acceleration_xaxis_delta = 0
last_acceleration_yaxis_delta = 0
last_acceleration_zaxis_delta = 0

sum_time_delta = 0

json.array!(@data_points.to_a) do |data_point|

	# calculations
	last_data_point ||= data_point

	if data_point.time_delta.present? && data_point.time_delta != 0
		time_delta = data_point.time_delta
	else
		time_delta = data_point.created_at.to_f - last_data_point.created_at.to_f
	end
	sum_time_delta = sum_time_delta + time_delta

	acceleration_xaxis_delta = ( data_point.acceleration_xaxis - last_data_point.acceleration_xaxis )
	acceleration_yaxis_delta = ( data_point.acceleration_yaxis - last_data_point.acceleration_yaxis )
	acceleration_zaxis_delta = ( data_point.acceleration_zaxis - last_data_point.acceleration_zaxis )

	acceleration_xaxis_delta_sum += acceleration_xaxis_delta
	acceleration_yaxis_delta_sum += acceleration_yaxis_delta
	acceleration_zaxis_delta_sum += acceleration_zaxis_delta

	corner_xaxis = ( last_acceleration_xaxis_delta > 0 && acceleration_xaxis_delta < 0 ) || ( last_acceleration_xaxis_delta < 0 && acceleration_xaxis_delta > 0 )
	corner_yaxis = ( last_acceleration_yaxis_delta > 0 && acceleration_yaxis_delta < 0 ) || ( last_acceleration_yaxis_delta < 0 && acceleration_yaxis_delta > 0 )
	corner_zaxis = ( last_acceleration_zaxis_delta > 0 && acceleration_zaxis_delta < 0 ) || ( last_acceleration_zaxis_delta < 0 && acceleration_zaxis_delta > 0 )


	# JSON
	json.id data_point.id

	json.logged_at data_point.logged_at.try(:to_f)
	json.logged_at_from_now data_point.logged_at.to_f - Time.now.to_f

	json.device_id data_point.device_id
	json.device_name data_point.device_name

	json.date data_point.date
	json.time data_point.time

	json.timestamp data_point.created_at.to_f
	json.time_delta time_delta
	json.sum_time_delta sum_time_delta

	json.acceleration_xaxis_delta data_point.acceleration_xaxis_delta
	json.acceleration_yaxis_delta data_point.acceleration_yaxis_delta
	json.acceleration_zaxis_delta data_point.acceleration_zaxis_delta

	json.acceleration_xaxis_delta_sum acceleration_xaxis_delta_sum
	json.acceleration_yaxis_delta_sum acceleration_yaxis_delta_sum
	json.acceleration_zaxis_delta_sum acceleration_zaxis_delta_sum

	json.acceleration_xaxis data_point.acceleration_xaxis
	json.acceleration_yaxis data_point.acceleration_yaxis
	json.acceleration_zaxis data_point.acceleration_zaxis

	json.acceleration_magnitude data_point.acceleration_vector_length

	json.angular_velocity_xaxis data_point.angular_velocity_xaxis
	json.angular_velocity_yaxis data_point.angular_velocity_yaxis
	json.angular_velocity_zaxis data_point.angular_velocity_zaxis

	json.angle_xaxis data_point.angle_xaxis
	json.angle_yaxis data_point.angle_yaxis
	json.angle_zaxis data_point.angle_zaxis

	json.acceleration_xaxis_corner corner_xaxis
	json.acceleration_yaxis_corner corner_yaxis
	json.acceleration_zaxis_corner corner_zaxis

	last_data_point = data_point
	last_acceleration_xaxis_delta = acceleration_xaxis_delta
	last_acceleration_yaxis_delta = acceleration_yaxis_delta
	last_acceleration_zaxis_delta = acceleration_zaxis_delta
end
