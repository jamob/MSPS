module SessionsHelper
#basic tests to enable bloody login
  
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def signed_in_user?(user)
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in"
    end
  end
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  def signed_out_user
    unless !signed_in?
      redirect_to root_path, notice: "Please sign out first"
    end
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def admin_user
    if !signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    elsif !admin?
      store_location
      redirect_to root_path, notice: "What are you trying to do?"
    end
  end
end
