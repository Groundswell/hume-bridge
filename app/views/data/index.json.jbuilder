json.array!(@data_points.to_a) do |data_point|
	json.id data_point.id
	json.device_id data_point.device_id
	json.device_name data_point.device_name
	json.date data_point.date
	json.time data_point.time
	json.acceleration_xaxis data_point.acceleration_xaxis
	json.acceleration_yaxis data_point.acceleration_yaxis
	json.acceleration_zaxis data_point.acceleration_zaxis
	json.angular_velocity_xaxis data_point.angular_velocity_xaxis
	json.angular_velocity_yaxis data_point.angular_velocity_yaxis
	json.angular_velocity_zaxis data_point.angular_velocity_zaxis
	json.angle_xaxis data_point.angle_xaxis
	json.angle_yaxis data_point.angle_yaxis
	json.angle_zaxis data_point.angle_zaxis
	# json.raw_data data_point.raw_data
end
