module SessionsHelper
  
  def sign_in(user)
    cookies.permanent.signed[:remeber_token] = [user.id, user.salt]
    current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  private
    
    def user_from_remember_token
      User.authenticate_with_salt(*rememeber_token)
    end
    
    def rememeber_token
      cookies.signed[:remeber_token] || [nil, nil]
    end
    
end
