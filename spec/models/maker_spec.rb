require 'rails_helper'

describe Maker do
  fixtures :makers

  context 'when asked for .batch_update' do
    it 'saves the new makers given' do
      makers = Maker.all.to_a
      makers << Maker.new(name: 'NewMaker', webmotors_id: 3)

      Maker.batch_update(makers)

      expect(Maker.all.any? { |maker| maker.name == 'NewMaker'} ).to be_truthy
    end
  end
end