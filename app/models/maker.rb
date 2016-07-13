class Maker < ActiveRecord::Base
  has_many :models

  def self.batch_update(makers)
    makers.each do |maker|
      maker.save unless Maker.exists?(name: maker.name)
    end
  end
end
