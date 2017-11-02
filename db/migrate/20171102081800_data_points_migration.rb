class DataPointsMigration < ActiveRecord::Migration

	def change

		create_table :data_points do |t|

			t.string			:device_id
			t.string			:device_name
			t.string			:date
			t.string			:time
			t.float				:acceleration_xaxis
			t.float				:acceleration_yaxis
			t.float				:acceleration_zaxis
			t.float				:angular_velocity_xaxis
			t.float				:angular_velocity_yaxis
			t.float				:angular_velocity_zaxis
			t.float				:angle_xaxis
			t.float				:angle_yaxis
			t.float				:angle_zaxis
			t.text				:raw_data

			t.timestamps
		end

		add_index :data_points, [:device_id, :id]

	end
end
