class ChangeModelColumnNameMakeIdToMakerId < ActiveRecord::Migration
  def change
    rename_column :models, :make_id, :maker_id
  end
end
