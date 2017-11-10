class NewsController < ApplicationController
  def index
    @news = New.paginate(page: params[:page], per_page: Settings.per_page_default)
  end

  def show
    @newdetail = New.find_by_id params[:id]
    if @newdetail
      @comments = @newdetail.comments.desc.includes(:user).paginate(page:
        params[:page], per_page: Settings.paginate_comment)
    else
      flash[:danger] = t "controller.comment.not_found"
      redirect_to root_path
    end
  end
end
