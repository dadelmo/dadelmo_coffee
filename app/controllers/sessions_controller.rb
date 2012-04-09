class SessionsController < ApplicationController
  def new
    user_signed = signed_in_user
    redirect_to account_show_path unless user_signed.nil?
  end

  def create
    email = params[:session][:email]
    if email.blank?
      flash[:error] = 'El email no puede ser vacio'
      redirect_to root_path
      return
    end
    user = User.find_by_email email
    if user.nil?
      user = User.create(:email => email)
      flash[:success] = "Te has dado de alta ¡Bienvenido #{email}!"
    end
    sign_in user
    redirect_to account_show_path
  end

  def destroy
    sign_out
    redirect_to signin_path
  end

  def signed_in?
    !signed_in_user.nil?
  end
  
end
