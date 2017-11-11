last_data_point = nil


sum_delta_acceleration_xaxis = 0
sum_delta_acceleration_yaxis = 0
sum_delta_acceleration_zaxis = 0

sum_time_delta = 0

json.array!(@data_points.to_a) do |data_point|
	last_data_point ||= data_point

	if data_point.time_delta.present? && data_point.time_delta != 0
		time_delta = data_point.time_delta
	else
		time_delta = data_point.created_at.to_f - last_data_point.created_at.to_f
	end
	sum_time_delta = sum_time_delta + time_delta

	delta_acceleration_xaxis = ( data_point.acceleration_xaxis - last_data_point.acceleration_xaxis )
	delta_acceleration_yaxis = ( data_point.acceleration_yaxis - last_data_point.acceleration_yaxis )
	delta_acceleration_zaxis = ( data_point.acceleration_zaxis - last_data_point.acceleration_zaxis )

	sum_delta_acceleration_xaxis += delta_acceleration_xaxis
	sum_delta_acceleration_yaxis += delta_acceleration_yaxis
	sum_delta_acceleration_zaxis += delta_acceleration_zaxis


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

	json.delta_acceleration_xaxis delta_acceleration_xaxis
	json.delta_acceleration_yaxis delta_acceleration_yaxis
	json.delta_acceleration_zaxis delta_acceleration_zaxis

	json.sum_delta_acceleration_xaxis sum_delta_acceleration_xaxis
	json.sum_delta_acceleration_yaxis sum_delta_acceleration_yaxis
	json.sum_delta_acceleration_zaxis sum_delta_acceleration_zaxis

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

	# json.raw_data data_point.raw_data

	# json.acceleration_minus_gravity_xaxis data_point.corrected_acceleration_xaxis
	# json.acceleration_minus_gravity_yaxis data_point.corrected_acceleration_yaxis
	# json.acceleration_minus_gravity_zaxis data_point.corrected_acceleration_zaxis
	# json.acceleration_minus_gravity_magnitude data_point.corrected_acceleration_vector_length

	last_data_point = data_point
end
