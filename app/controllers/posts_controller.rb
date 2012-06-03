class PostsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @button_title = "Submit post"
  end
  
  def create
    @post = Post.new
    @post.accessible = :all if current_user.admin?
    @post.attributes = params[:post]
    @post.author = current_user.full_name
    @post.date = Time.now.strftime("%l:%M %p, %e/%m/%Y")

    if @post.save
      flash[:notice] = "Post created"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @button_title = "Save changes"
  end

  def update
    @post = Post.find(params[:id])
    @post.accessible = :all if current_user.admin?

    if @post.update_attributes(params[:post])
      flash[:notice] = "Post updated"
      redirect_to posts_path
    else
      flash[:notice] = "It would seem we have an error my good sir."
      redirect_to posts_path
    end
  end
  
  def destroy
    Post.find(params[:id]).destroy
    flash[:notice] = "Post deleted"
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
  end
end
