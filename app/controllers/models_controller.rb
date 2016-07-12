class ModelsController < ApplicationController
  def index
    #search the models
    uri = URI("http://www.webmotors.com.br/carro/modelos")

    # Make request for Webmotors site
    maker = Maker.where(webmotors_id: params[:webmotors_maker_id])[0]

    response = Net::HTTP.post_form(uri, { marca: params[:webmotors_maker_id] })
    models_json = JSON.parse response.body

    # debugger

    # Itera no resultado e grava os modelos que ainda não estão persistidas
    models_json.each do |json|
      if Model.where(name: json["Nome"], maker_id: maker.id).size == 0
        Model.create(maker_id: maker.id, name: json["Nome"])
      end
    end
  end
end
