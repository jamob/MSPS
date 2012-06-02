module PostsHelper
  
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
end
