module SessionsHelper
  
  def sign_in user
    cookies.permanent.signed[:remember_token] = [user.id]
    self.current_user = user
  end

  def sign_out
    cookies.delete :remember_token
    self.current_user = nil
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def signed_in_user
    User.find_by_id cookies.signed[:remember_token]
  end
  
  def sign_in?
    !signed_in_user.nil?
  end
  
  def deny_access
    redirect_to signin_path, :notice => "Por favor, conectacte"
  end

  def check_admin
    
      redirect_to account_show_path, :notice => "Acceso restringido" unless (signed_in_user.email == 'dadelmo@gmail.com' || signed_in_user.email == 'daniel@alice.com')
  end

  def is_admin?
      signed_in_user.email == 'dadelmo@gmail.com' || signed_in_user.email == 'daniel@alice.com'
  end

end
