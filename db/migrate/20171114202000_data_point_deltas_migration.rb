class DataPointDeltasMigration < ActiveRecord::Migration

	def change

		add_column :data_points, :time_start, :datetime, default: nil
		add_column :data_points, :acceleration_xaxis_delta, :float, default: nil
		add_column :data_points, :acceleration_yaxis_delta, :float, default: nil
		add_column :data_points, :acceleration_zaxis_delta, :float, default: nil
		add_column :data_points, :acceleration_xaxis_delta_sum, :float, default: nil
		add_column :data_points, :acceleration_yaxis_delta_sum, :float, default: nil
		add_column :data_points, :acceleration_zaxis_delta_sum, :float, default: nil
		add_column :data_points, :acceleration_xaxis_corner, :boolean, default: false
		add_column :data_points, :acceleration_yaxis_corner, :boolean, default: false
		add_column :data_points, :acceleration_zaxis_corner, :boolean, default: false

		add_index :data_points, :time_start
		add_index :data_points, :acceleration_xaxis_corner
		add_index :data_points, :acceleration_yaxis_corner
		add_index :data_points, :acceleration_zaxis_corner

	end
end
