class SatellitesController < ApplicationController
  
  def show
  	@satellite = Satellite.find(params[:id])
  end

  def index
    @satellites = Satellite.all
  end
end
