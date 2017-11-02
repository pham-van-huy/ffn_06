class SearchsController < ApplicationController
  def show
    @result = {}
    key = params[:searchs][:key].tr " ", "|"
    @result[:leagues] = League.get_search(key).paginate page: params[:page], per_page: Settings.per_page_default
    @result[:teams] = Team.get_search(key).paginate page: params[:page], per_page: Settings.per_page_default
    @result[:key] = params[:searchs][:key]
  end
end
