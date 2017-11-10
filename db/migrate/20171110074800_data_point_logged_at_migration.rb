class DataPointLoggedAtMigration < ActiveRecord::Migration

	def change

		add_column :data_points, :logged_at, :datetime, default: nil
		add_column :data_points, :time_delta, :float, default: nil
		add_index :data_points, :logged_at

	end
end
