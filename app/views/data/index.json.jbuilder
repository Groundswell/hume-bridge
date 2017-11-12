last_data_point = nil


last_corner_xaxis = nil
last_corner_yaxis = nil
last_corner_zaxis = nil
last_corner_xzaxis = nil
last_corner_xyaxis = nil
last_corner_yzaxis = nil

sum_delta_acceleration_xaxis = 0
sum_delta_acceleration_yaxis = 0
sum_delta_acceleration_zaxis = 0

last_delta_acceleration_xaxis = 0
last_delta_acceleration_yaxis = 0
last_delta_acceleration_zaxis = 0

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

	delta_acceleration_xaxis = ( data_point.acceleration_xaxis - last_data_point.acceleration_xaxis )
	delta_acceleration_yaxis = ( data_point.acceleration_yaxis - last_data_point.acceleration_yaxis )
	delta_acceleration_zaxis = ( data_point.acceleration_zaxis - last_data_point.acceleration_zaxis )

	sum_delta_acceleration_xaxis += delta_acceleration_xaxis
	sum_delta_acceleration_yaxis += delta_acceleration_yaxis
	sum_delta_acceleration_zaxis += delta_acceleration_zaxis

	corner_xaxis = ( last_delta_acceleration_xaxis > 0 && delta_acceleration_xaxis < 0 ) || ( last_delta_acceleration_xaxis < 0 && delta_acceleration_xaxis > 0 )
	corner_yaxis = ( last_delta_acceleration_yaxis > 0 && delta_acceleration_yaxis < 0 ) || ( last_delta_acceleration_yaxis < 0 && delta_acceleration_yaxis > 0 )
	corner_zaxis = ( last_delta_acceleration_zaxis > 0 && delta_acceleration_zaxis < 0 ) || ( last_delta_acceleration_zaxis < 0 && delta_acceleration_zaxis > 0 )

	major_corner_xyaxis ||= corner_xaxis && last_corner_xyaxis && ( (sum_delta_acceleration_xaxis - last_corner_xyaxis[:x]) / (sum_delta_acceleration_yaxis - last_corner_xyaxis[:y]) ).abs > 0.6
	major_corner_xyaxis ||= corner_yaxis && last_corner_xyaxis && ( (sum_delta_acceleration_yaxis - last_corner_xyaxis[:y]) / (sum_delta_acceleration_xaxis - last_corner_xyaxis[:x]) ).abs > 0.6
	major_corner_xzaxis ||= corner_xaxis && last_corner_xzaxis && ( (sum_delta_acceleration_xaxis - last_corner_xzaxis[:x]) / (sum_delta_acceleration_zaxis - last_corner_xzaxis[:z]) ).abs > 0.6
	major_corner_xzaxis ||= corner_zaxis && last_corner_xzaxis && ( (sum_delta_acceleration_zaxis - last_corner_xzaxis[:z]) / (sum_delta_acceleration_xaxis - last_corner_xzaxis[:x]) ).abs > 0.6
	major_corner_yzaxis ||= corner_yaxis && last_corner_yzaxis && ( (sum_delta_acceleration_yaxis - last_corner_yzaxis[:x]) / (sum_delta_acceleration_zaxis - last_corner_yzaxis[:z]) ).abs > 0.6
	major_corner_yzaxis ||= corner_zaxis && last_corner_yzaxis && ( (sum_delta_acceleration_zaxis - last_corner_yzaxis[:z]) / (sum_delta_acceleration_yaxis - last_corner_yzaxis[:x]) ).abs > 0.6

	last_corner_xzaxis = last_corner_xyaxis = last_corner_xaxis = { x: sum_delta_acceleration_xaxis, y: sum_delta_acceleration_yaxis, z: sum_delta_acceleration_zaxis  } if corner_xaxis
	last_corner_yzaxis = last_corner_xyaxis = last_corner_yaxis = { x: sum_delta_acceleration_xaxis, y: sum_delta_acceleration_yaxis, z: sum_delta_acceleration_zaxis  } if corner_yaxis
	last_corner_yzaxis = last_corner_xzaxis = last_corner_zaxis = { x: sum_delta_acceleration_xaxis, y: sum_delta_acceleration_yaxis, z: sum_delta_acceleration_zaxis  } if corner_zaxis





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

	json.corner_xaxis corner_xaxis
	json.corner_yaxis corner_yaxis
	json.corner_zaxis corner_zaxis
	json.major_corner_xyaxis major_corner_xyaxis
	json.major_corner_xzaxis major_corner_xzaxis
	json.major_corner_yzaxis major_corner_yzaxis
	json.major_corner_yxaxis major_corner_xyaxis
	json.major_corner_zxaxis major_corner_xzaxis
	json.major_corner_zyaxis major_corner_yzaxis

	last_data_point = data_point
	last_delta_acceleration_xaxis = delta_acceleration_xaxis
	last_delta_acceleration_yaxis = delta_acceleration_yaxis
	last_delta_acceleration_zaxis = delta_acceleration_zaxis
end
