module Webmotors
  class Gateway
    MAKERS_URL = 'http://www.webmotors.com.br/carro/marcas'
    MODELS_URL = 'http://www.webmotors.com.br/carro/modelos'

    def initialize(overrides = {})
      @adapter = overrides.fetch(:adapter) { Webmotors::Adapter.new }
    end

    def makers
      response = Net::HTTP.post_form(URI(MAKERS_URL), {})

      @adapter.translate_makers(response.body)
    end

    def models(maker)
      response = Net::HTTP.post_form(URI(MODELS_URL), { marca: maker.webmotors_id })

      @adapter.translate_models(response.body, maker)
    end
  end
end
