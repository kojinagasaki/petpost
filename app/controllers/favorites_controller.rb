class FavoritesController < ApplicationController
  def create
    photopost = Photopost.find(params[:photopost_id])
    current_user.like(photopost)
    flash[:success] = 'お気に入りにしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
   photopost = Photopost.find(params[:photopost_id])
    current_user.unlike photopost
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
