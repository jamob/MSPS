class SessionsController < ApplicationController
  before_filter :signed_out_user, only: [:create, :new]
  def new
  end

  def create
    user = User.find_by_name(params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or root_path
    else
      flash.now[:error] = "Invalid name/password combination"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
