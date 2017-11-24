class SatellitesController < ApplicationController
  def index
    @satellites = Satellite.all
  end
end
