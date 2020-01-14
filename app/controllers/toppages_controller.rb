class ToppagesController < ApplicationController
  def index
    if logged_in?
      @photopost = current_user.photoposts.build  # form_with 用
      @photoposts = current_user.feed_photoposts.order(id: :desc).page(params[:page])
    end
  end
end
