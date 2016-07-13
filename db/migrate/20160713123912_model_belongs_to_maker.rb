class ModelBelongsToMaker < ActiveRecord::Migration
  def change
    add_foreign_key :models, :maker
  end
end
