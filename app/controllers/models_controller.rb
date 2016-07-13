class ModelsController < ApplicationController
  def index
    params.require :webmotors_maker_id

    maker = Maker.find_by webmotors_id: params[:webmotors_maker_id]
    webmotors_models = Webmotors::Gateway.new.models(maker)
    
    Model.batch_update webmotors_models

    @models = maker.models
  end
end
