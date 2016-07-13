class HomeController < ApplicationController
  def index
    webmotors_makers = Webmotors::Gateway.new.makers

    Maker.batch_update webmotors_makers

    @makers = Maker.all
  end
end
