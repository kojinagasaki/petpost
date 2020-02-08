class CommentsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @photopost = Photopost.find(params[:photopost_id])
    @comment = current_user.comments.build(comment_params)
    @comment.photopost_id = params[:photopost_id]
    if @comment.save
      flash[:success] = "コメントしました。"
      redirect_back(fallback_location: root_url)
    else
      flash[:danger] = "コメントできませんでした。"
      redirect_back(fallback_location: root_url)
    end 
  end

  def destroy
    photopost = Photopost.find(params[:Photopost_id])
    @comment = photopost.comments.find(params[:id])
    redirect_back(fallback_location: root_url)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
