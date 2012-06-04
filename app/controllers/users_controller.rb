class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :admin_user,     only: [:destroy, :index, :create, :new]
  before_filter :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def contact
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Creation Success!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.accessible = :all if current_user.admin?
    
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      if !current_user.admin?
        sign_in @user
      end
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def index
    @users = User.all
  end

  def home
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user) || current_user.admin?
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
