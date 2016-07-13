require 'rails_helper'

describe Model do
  fixtures :models

  context 'when asked for .batch_update' do
    it 'saves the new models given' do
      makers = Model.all.to_a
      makers << Model.new(name: 'NewModel', maker_id: 1)

      Model.batch_update(makers)

      expect(Model.all.any? { |model| model.name == 'NewModel'} ).to be_truthy
    end
  end
end