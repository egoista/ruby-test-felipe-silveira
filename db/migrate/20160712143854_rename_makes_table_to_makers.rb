class RenameMakesTableToMakers < ActiveRecord::Migration
  def change
    rename_table :makes, :makers
  end
end
