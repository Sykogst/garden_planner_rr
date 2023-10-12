class CreateOrganisms < ActiveRecord::Migration[7.0]
  def change
    create_table :organisms do |t|
      t.string :name
      t.boolean :plant
      t.string :max_size_sqft

      t.timestamps
    end
  end
end
