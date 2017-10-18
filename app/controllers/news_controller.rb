class NewsController < ApplicationController
  def index
    @news = New.paginate(page: params[:page], per_page: Settings.per_page_default)
  end

  def show;
    @new = New.find_by_id(params[:id])
    if @new
        @comments = @new.comments.includes(:user).paginate(page: params[:page], per_page: Settings.paginate_comment)
    else
        flash[:danger] = t "controller.comment.not_found"
        redirect_to root_path
    end
  end
end
