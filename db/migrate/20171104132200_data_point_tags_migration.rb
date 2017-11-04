class DataPointTagsMigration < ActiveRecord::Migration

	def change

		add_column :data_points, :tags, :string, array: true, default: '{}'
		add_index :data_points, :tags, using: 'gin'

	end
end
