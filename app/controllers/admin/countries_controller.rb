class Admin::CountriesController < ApplicationController
  def get_by_league
    countries = Country.get_by_continent(params[:continent_id])
    respond_to do |format|
      format.json{render json: countries}
    end
  end
end
