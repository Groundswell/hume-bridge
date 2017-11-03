class DataPoint < ActiveRecord::Base

	def acceleration_vector_length
		Math.sqrt( acceleration_xaxis**2 + acceleration_yaxis**2 + acceleration_zaxis**2 )
	end

	def acceleration_vector_angle_xaxis
		# to_degrees( Math.asin( acceleration_yaxis / acceleration_vector_length.to_f ) )
		to_degrees( Math.atan2( acceleration_yaxis, acceleration_zaxis ) )
	end

	def acceleration_vector_angle_yaxis
		# to_degrees( Math.asin( acceleration_yaxis / acceleration_vector_length.to_f ) )
		-to_degrees( Math.atan2( acceleration_xaxis, acceleration_zaxis ) )
	end

	def acceleration_vector_angle_zaxis
		# to_degrees( Math.asin( acceleration_xaxis / acceleration_vector_length.to_f ) )
		to_degrees( Math.atan2( acceleration_yaxis, acceleration_xaxis ) )
	end

	def to_radians( degrees )
		degrees/180 * Math::PI
	end

	def to_degrees( radians )
		radians * (180/Math::PI)
	end

	def compare_angles
		puts "#{self.acceleration_vector_angle_xaxis},#{self.acceleration_vector_angle_yaxis},#{self.acceleration_vector_angle_zaxis}"
		puts "#{self.angle_xaxis},#{self.angle_yaxis},#{self.angle_zaxis}"
		puts "#{self.angle_xaxis - self.acceleration_vector_angle_xaxis},#{self.angle_yaxis - self.acceleration_vector_angle_yaxis},#{self.angle_zaxis - self.acceleration_vector_angle_zaxis}"
	end

end
