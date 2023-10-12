class CorrectPlotsColumnNameArabableToArable < ActiveRecord::Migration[7.0]
  def change
    rename_column('plots', 'arabale', 'arable')
  end
end
