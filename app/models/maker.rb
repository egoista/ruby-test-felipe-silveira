class Maker < ActiveRecord::Base
  has_many :models

  def self.batch_update(makers)
    persisted_makers = self.all
    diff_makers = makers.keep_if{ |maker| not persisted_makers.any? { |p_maker| p_maker.name == maker.name }}
    diff_makers.each{ |maker| maker.save}
  end
end
