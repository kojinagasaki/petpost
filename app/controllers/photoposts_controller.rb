class PhotopostsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def index
   @photoposts = Photopost.all.order(id: :desc).page(params[:page]).per(6)
  end

  def show
    @photopost = Photopost.find(params[:id])
    @user = @photopost.user
    @photoposts = Photopost.all.order(id: :desc).first(3)
    @comments = @photopost.comments
    count(@photopost)
  end

  def new
    @photopost = current_user.photoposts.build
  end

  def create
    @photopost = current_user.photoposts.build(photopost_params)
    if @photopost.save
      # @photopost.update(category: category.@photopost.category.to_i)
      flash[:success] = '写真を投稿しました。'
      redirect_to root_url
    else
      @photoposts = current_user.feed_photoposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = '写真の投稿に失敗しました。'
      render 'photoposts/new'
    end
  end

  def destroy
    @photopost.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def search
    if params[:content].present?
      @photoposts = Photopost.where('content LIKE ?', "%#{params[:content]}%").order(id: :desc).page(params[:page]).per(6)
    else
      @photoposts = Photopost.none
    end
  end
  
  def ranking
     @all_ranks = Photopost.find(Favorite.group(:photopost_id).order('count(photopost_id) desc').pluck(:photopost_id))
     @ranks = Kaminari.paginate_array(@all_ranks).page(params[:page]).per(6)
  end
  
  def category
    @photoposts = Photopost.where(category: params[:category]).order(id: :desc).page(params[:page]).per(6)
    @category = params[:category]
  end
  
  private

  def photopost_params
    params.require(:photopost).permit(:title, :content, :img, :category)
  end
  
  def correct_user
    @photopost = current_user.photoposts.find_by(id: params[:id])
    unless @photopost
      redirect_to root_url
    end
  end
end
