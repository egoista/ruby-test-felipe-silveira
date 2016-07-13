class ModelsController < ApplicationController
  def index
    params.require :webmotors_maker_id

    maker = Maker.find_by webmotors_id: params[:webmotors_maker_id]

    webmotors_models = Webmotors::Gateway.new.models(maker)

    # Itera no resultado e grava os modelos que ainda não estão persistidas
    webmotors_models.each do |webmotors_model|
      webmotors_model.save unless Model.exists?(name: webmotors_model.name, maker_id: webmotors_model.maker_id)
    end

    @models = maker.models
  end
end
