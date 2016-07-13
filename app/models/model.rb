class Model < ActiveRecord::Base
  belongs_to :customer

  def self.batch_update(models)
    models.each do |model|
      model.save unless Model.exists?(name: model.name, maker_id: model.maker_id)
    end
  end
end
