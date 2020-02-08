class ApplicationController < ActionController::Base
  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  def counts(user)
    @count_photoposts = user.photoposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_favorites = user.likings.count
  end
  def count(photopost)
    @count_liked = photopost.liked.count
  end
end
