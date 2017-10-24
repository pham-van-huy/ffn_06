class CommentsController < ApplicationController
  before_action :check_login

  def create
    post = New.find_by_id params[:new_id]
    if post
      new_comment = post.comments.create(user_id: current_user.id, content: params[:content])
      respond_to do |format|
        msg = {status: 200, user: current_user, new_comment: new_comment}
        format.json{render json: msg}
      end
    else
      respond_to do |format|
        msg = {status: 404, message: t("controller.comment.not_found")}
        format.json{render json: msg}
      end
    end
  end

  def update
    comment = Comment.find params[:id]
    comment = comment.update_attribute(:content, params[:content])
    respond_to do |format|
      msg = {comment: comment, status: true}
      format.json{render json: msg}
    end
  rescue
    respond_to do |format|
      msg = {comment: comment, status: false}
      format.json{render json: msg}
    end
  end

  def destroy
    comment = Comment.find_by_id params[:id]
    if comment.destroy
      respond_to do |format|
        msg = {status: true}
        format.json{render json: msg}
      end
    else
      respond_to do |format|
        msg = {status: false}
        format.json{render json: msg}
      end
    end
  end

  private
  def check_login
    unless logged_in?
      respond_to do |format|
        msg = {status: false, message: t("controller.comment.not_login")}
        format.json{render json: msg}
      end
    end
  end
end
