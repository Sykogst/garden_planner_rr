class CreatePlots < ActiveRecord::Migration[7.0]
  def change
    create_table :plots do |t|
      t.string :name
      t.boolean :arabale
      t.float :area_sqft

      t.timestamps
    end
  end
end
