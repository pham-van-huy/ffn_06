class NewsController < ApplicationController
  def index
    @news = New.paginate(page: params[:page], per_page: Settings.per_page_default)
  end

  def show; end
end
