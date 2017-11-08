class Admin::NewsController < ApplicationController
  before_action :get_new, only: [:destroy, :edit, :update]
  before_action :check_admin
  def index
    @news = New.includes(:comments).paginate(page: params[:page], per_page: Settings.per_page_new_admin)
  end

  def new
    @new = New.new
  end

  def create
    @new = current_user.new.build new_params
    if @new.save
      flash[:success] = t "admin.matchs.new.create_success"
      redirect_to news_path @new
    else
      flash[:danger] = t "admin.matchs.new.create_fail"
      render :new
    end
  end

  def destroy
    if @new.destroy
      flash[:success] = t "admin.matchs.new.delete_success"
    else
      flash[:danger] = t "admin.matchs.new.delete_fail"
    end
    redirect_to admin_news_index_path
  end

  def edit; end

  def update
    @new.update_attributes! new_params
    flash[:success] = t "admin.leagues.edit.update_success"
    redirect_to admin_news_index_path
  rescue
    flash[:danger] = t "admin.leagues.edit.update_fail"
    render :edit
  end

  private
  def new_params
    params.require(:new).permit :title, :content, :represent_image
  end

  def get_new
    @new = New.find_by_id params[:id]
    unless @new
      flash[:danger] = t "admin.matchs.new.not_found"
      redirect_to admin_news_index_path
    end
  end

  def check_admin
    redirect_to root_path unless logged_in? && current_user.role == "admin"
  end
end
