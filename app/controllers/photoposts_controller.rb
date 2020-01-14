class PhotopostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
  end

  def show
  end

  def new
  end

  def create
    @photopost = current_user.photoposts.build(photopost_params)
    if @photopost.save
      flash[:success] = '写真を投稿しました。'
      redirect_to root_url
    else
      @photoposts = current_user.photoposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = '写真の投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @photopost.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def photopost_params
    params.require(:photopost).permit(:title, :content, :img)
  end
  
  def correct_user
    @photopost = current_user.photoposts.find_by(id: params[:id])
    unless @photopost
      redirect_to root_url
    end
  end
end
