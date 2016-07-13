class Model < ActiveRecord::Base
  belongs_to :customer

  def self.batch_update(models)
    persisted_models = self.all
    diff_models = models.keep_if do |model|
      not persisted_models.any? { |p_model| p_model.name == model.name and p_model.maker_id == model.maker_id }
    end
    diff_models.each{ |model| model.save}
  end
end
