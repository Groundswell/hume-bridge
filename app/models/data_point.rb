# X - Roll - φ
# Y - Pitch - θ
# Z - Yaw - ψ

# accelleration:
# acc_x = 1g * sinθ * cosφ
# acc_y = - 1g * sinθ * sinφ
# acc_z = 1g * cosθ
# → acc_y/acc_x = - tanφ

class DataPoint < ActiveRecord::Base

	acts_as_taggable_array_on :tags

	def delta_antigravity
		{ xaxis: -angle_xaxis+90, yaxis: -angle_yaxis, zaxis: angle_zaxis }
	end

	def delta_gravity
		{ xaxis: -angle_xaxis-90, yaxis: -angle_yaxis, zaxis: angle_zaxis }
	end

	# angle 1g acceleration
	def angle_acceleration_xaxis
		Math.sin(to_radians(angle_yaxis)) * Math.cos(to_radians(angle_xaxis)) # acc_x = 1g * sinθ * cosφ
	end

	def angle_acceleration_yaxis
		- Math.sin(to_radians(angle_yaxis)) * Math.sin(to_radians(angle_xaxis)) # acc_y = - 1g * sinθ * sinφ
	end

	def angle_acceleration_zaxis
		Math.cos(to_radians(angle_yaxis)) # acc_z = 1g * cosθ
	end

	def angle_acceleration_vector_length
		Math.sqrt( angle_acceleration_xaxis**2 + angle_acceleration_yaxis**2 + angle_acceleration_zaxis**2 )
	end


	# gravity vector calculations
	def gravity_acceleration_xaxis
		Math.sin(to_radians(delta_gravity[:yaxis])) * Math.cos(to_radians(delta_gravity[:xaxis]))
	end

	def gravity_acceleration_yaxis
		- Math.sin(to_radians(delta_gravity[:yaxis])) * Math.sin(to_radians(delta_gravity[:xaxis]))
	end

	def gravity_acceleration_zaxis
		Math.cos(to_radians(delta_gravity[:yaxis]))
	end

	def gravity_acceleration_vector_length
		Math.sqrt( gravity_acceleration_xaxis**2 + gravity_acceleration_yaxis**2 + gravity_acceleration_zaxis**2 )
	end


	# corrected vector calculations
	def corrected_acceleration_xaxis
		acceleration_xaxis - gravity_acceleration_xaxis
	end

	def corrected_acceleration_yaxis
		acceleration_yaxis - gravity_acceleration_yaxis
	end

	def corrected_acceleration_zaxis
		acceleration_zaxis - gravity_acceleration_zaxis
	end

	def corrected_acceleration_vector_length
		Math.sqrt( corrected_acceleration_xaxis**2 + corrected_acceleration_yaxis**2 + corrected_acceleration_zaxis**2 )
	end



	# acceleration vector
	def acceleration_vector_angle_xaxis #pitch
		to_degrees( Math.atan2( acceleration_yaxis, acceleration_zaxis ) )
	end

	def acceleration_vector_angle_yaxis #yaw
		angle = to_degrees( Math.atan2( acceleration_zaxis, acceleration_xaxis ) )
		if acceleration_zaxis > 0
			angle = angle - 90
			angle = 360 + angle if angle < -180
		else
			angle = angle + 90
			angle = -360 + angle if angle > 180
		end

		angle
	end

	def acceleration_vector_angle_zaxis #roll
		# atan (accelerationY/sqrt(accelerationX*accelerationX + accelerationZ*accelerationZ)
		# to_degrees( Math.atan2( acceleration_yaxis, Math.sqrt( acceleration_xaxis**2 + acceleration_zaxis**2 ) ) )
		# to_degrees( Math.atan( -acceleration_xaxis / Math.sqrt( acceleration_yaxis**2 + acceleration_zaxis**2 ) ) )
		to_degrees( Math.atan2( acceleration_yaxis, acceleration_zaxis ) )
	end

	def acceleration_vector_length
		Math.sqrt( acceleration_xaxis**2 + acceleration_yaxis**2 + acceleration_zaxis**2 )
	end






	# helper fucntions
	def to_radians( degrees )
		degrees/180 * Math::PI
	end

	def to_degrees( radians )
		radians * (180/Math::PI)
	end

	def to_s
		JSON.pretty_generate( self.attributes.merge(
			acceleration_vector_length: self.acceleration_vector_length,

			# acceleration_vector_angle_xaxis: self.acceleration_vector_angle_xaxis,
			# acceleration_vector_angle_yaxis: self.acceleration_vector_angle_yaxis,
			# acceleration_vector_angle_zaxis: self.acceleration_vector_angle_zaxis,

			gravity_acceleration: '-----------------',
			gravity_acceleration_xaxis: self.gravity_acceleration_xaxis,
			gravity_acceleration_yaxis: self.gravity_acceleration_yaxis,
			gravity_acceleration_zaxis: self.gravity_acceleration_zaxis,
			gravity_acceleration_vector_length: self.gravity_acceleration_vector_length,

			corrected_acceleration: '-----------------',
			corrected_acceleration_xaxis: self.corrected_acceleration_xaxis,
			corrected_acceleration_yaxis: self.corrected_acceleration_yaxis,
			corrected_acceleration_zaxis: self.corrected_acceleration_zaxis,
			corrected_acceleration_vector_length: self.corrected_acceleration_vector_length,

			angle_acceleration: '-----------------',
			angle_acceleration_xaxis: self.angle_acceleration_xaxis,
			angle_acceleration_yaxis: self.angle_acceleration_yaxis,
			angle_acceleration_zaxis: self.angle_acceleration_zaxis,
			angle_acceleration_vector_length: self.angle_acceleration_vector_length,
		) )
	end

end
