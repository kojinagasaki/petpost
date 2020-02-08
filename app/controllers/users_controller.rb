class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index,:edit, :update, :destroy]
  
  def index
    @users = User.all.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @photoposts = @user.photoposts.order(id: :desc).first(3)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to root_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザを編集しました。'
      redirect_to @user  
    else
      flash.now[:danger] = 'ユーザの編集に失敗しました。'
      render :edit
    end  
  end

  def destroy
  end
  
  def followings
   @user = User.find(params[:id])
   @followings = @user.followings.page(params[:page])
   @photoposts =@user.feed__followings_photoposts.order(id: :desc).page(params[:page]).per(6)
   counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page]).per(12)
    counts(@user)
  end
  
  def likings
   @user = User.find(params[:id])
   @likings = @user.likings.page(params[:page]).per(6)
   counts(@user)
  end
  
  def photoposts
    @user = User.find(params[:id])
    @photoposts = @user.photoposts.order(id: :desc).page(params[:page]).per(6)
    counts(@user)
  end
  
  def password
     @user = User.find(params[:id])
  end
  
  def search
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%").order(id: :desc).page(params[:page]).per(25)
    else
      @users = Photopost.none
    end
  end
    
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :back_img, :icon, :content)
  end
end
