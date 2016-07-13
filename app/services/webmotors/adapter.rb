module Webmotors
  class Adapter
    def translate_makers(makers_json)
      makers = []
      JSON.parse(makers_json).each do |maker|
        makers << Maker.new(name: maker["Nome"], webmotors_id: maker["Id"])
      end

      makers
    end

    def translate_models(models_json, maker)
      models = []
      JSON.parse(models_json).each do |model|
        models << Model.new(name: model["Nome"], maker_id: maker.id)
      end

      models
    end
  end
end
