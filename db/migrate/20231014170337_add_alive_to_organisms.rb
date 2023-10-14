class AddAliveToOrganisms < ActiveRecord::Migration[7.0]
  def change
    add_column :organisms, :alive, :boolean
  end
end
