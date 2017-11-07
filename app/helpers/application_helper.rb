module ApplicationHelper

	def color_from_integer( i )

		r = 0
		g = 0
		b = 0

		if i < 256
			r = i
		elsif i < 512
			r = 255
			g = (i - 255)
		elsif i < 768
			r = 255 - (i - 511)
			g = 255
		elsif i < 1024
			g = 255
			b = (i - 768)
		elsif i < 1280
			g = 255 - (i - 1023)
			b = 255
		elsif i < 1536
			b = 255
			r = (i - 1280)
		elsif i < 1792
			b = 255 - (i - 1535)
			r = 255
		else
		end


		[ r, g, b ]

	end

end
