class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.paginate(page: params[:page], per_page: 3).order("created_at DESC")
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 3).order("created_at DESC")
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your profile was updated successfully"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Alpha Blog 👉 #{@user.username.upcase} 👈"
      redirect_to articles_path
    else
      render 'new'
    end
  end


  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
