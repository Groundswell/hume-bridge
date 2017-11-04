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

	def acceleration_vector_length
		Math.sqrt( acceleration_xaxis**2 + acceleration_yaxis**2 + acceleration_zaxis**2 )
	end

	def delta_antigravity
		{ xaxis: -angle_xaxis+90, yaxis: -angle_yaxis, zaxis: angle_zaxis }
	end

	def delta_gravity
		{ xaxis: -angle_xaxis-90, yaxis: -angle_yaxis, zaxis: angle_zaxis }
	end

	# angle 1g acceleration
	def angle_1g_acceleration_xaxis
		Math.sin(angle_yaxis) * Math.cos(angle_xaxis) # acc_x = 1g * sinθ * cosφ
	end

	def angle_1g_acceleration_yaxis
		- Math.sin(angle_yaxis) * Math.sin(angle_xaxis) # acc_y = - 1g * sinθ * sinφ
	end

	def angle_1g_acceleration_zaxis
		Math.cos(angle_yaxis) # acc_z = 1g * cosθ
	end

	def angle_1g_acceleration_vector_length
		Math.sqrt( angle_1g_acceleration_xaxis**2 + angle_1g_acceleration_yaxis**2 + angle_1g_acceleration_zaxis**2 )
	end


	# gravity vector calculations
	def gravity_acceleration_xaxis
		Math.sin(delta_gravity[:yaxis]) * Math.cos(delta_gravity[:xaxis])
	end

	def gravity_acceleration_yaxis
		- Math.sin(delta_gravity[:yaxis]) * Math.sin(delta_gravity[:xaxis])
	end

	def gravity_acceleration_zaxis
		Math.cos(delta_gravity[:yaxis])
	end

	def gravity_acceleration_vector_length
		Math.sqrt( gravity_acceleration_xaxis**2 + gravity_acceleration_yaxis**2 + gravity_acceleration_zaxis**2 )
	end


	# antigravity vector calculations
	def antigravity_acceleration_xaxis
		Math.sin(delta_antigravity[:yaxis]) * Math.cos(delta_antigravity[:xaxis])
	end

	def antigravity_acceleration_yaxis
		- Math.sin(delta_antigravity[:yaxis]) * Math.sin(delta_antigravity[:xaxis])
	end

	def antigravity_acceleration_zaxis
		Math.cos(delta_antigravity[:yaxis])
	end

	def antigravity_acceleration_vector_length
		Math.sqrt( antigravity_acceleration_xaxis**2 + antigravity_acceleration_yaxis**2 + antigravity_acceleration_zaxis**2 )
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


	# helper fucntions
	def to_radians( degrees )
		degrees/180 * Math::PI
	end

	def to_degrees( radians )
		radians * (180/Math::PI)
	end

	def to_s
		JSON.pretty_generate( self.attributes.merge(
			acceleration_vector_angle_xaxis: self.acceleration_vector_angle_xaxis,
			acceleration_vector_angle_yaxis: self.acceleration_vector_angle_yaxis,
			acceleration_vector_angle_zaxis: self.acceleration_vector_angle_zaxis,

			delta_antigravity: delta_antigravity,
			antigravity_acceleration_xaxis: self.antigravity_acceleration_xaxis,
			antigravity_acceleration_yaxis: self.antigravity_acceleration_yaxis,
			antigravity_acceleration_zaxis: self.antigravity_acceleration_zaxis,
			antigravity_acceleration_vector_length: self.antigravity_acceleration_vector_length,

			delta_gravity: delta_gravity,
			gravity_acceleration_xaxis: self.gravity_acceleration_xaxis,
			gravity_acceleration_yaxis: self.gravity_acceleration_yaxis,
			gravity_acceleration_zaxis: self.gravity_acceleration_zaxis,
			gravity_acceleration_vector_length: self.gravity_acceleration_vector_length,

			angle_1g_acceleration_xaxis: self.angle_1g_acceleration_xaxis,
			angle_1g_acceleration_yaxis: self.angle_1g_acceleration_yaxis,
			angle_1g_acceleration_zaxis: self.angle_1g_acceleration_zaxis,
			angle_1g_acceleration_vector_length: self.angle_1g_acceleration_vector_length,
		) )
	end

end
