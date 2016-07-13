class HomeController < ApplicationController
  def index
    webmotors_makers = Webmotors::Gateway.new.makers

    # Itera no resultado e grava as marcas que ainda não estão persistidas
    webmotors_makers.each do |webmotor_maker|
      webmotor_maker.save unless Maker.exists?(name: webmotor_maker.name)
    end

    @makers = Maker.all
  end
end
