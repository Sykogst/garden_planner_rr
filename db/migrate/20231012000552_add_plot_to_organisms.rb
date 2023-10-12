class AddPlotToOrganisms < ActiveRecord::Migration[7.0]
  def change
    add_reference :organisms, :plot, null: false, foreign_key: true
  end
end
