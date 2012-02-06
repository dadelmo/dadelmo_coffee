class SessionsController < ApplicationController
  def new
    user_signed = signed_in_user
    redirect_to account_show_path unless user_signed.nil?
  end

  def create
    email = params[:session][:email]
    user = User.find_by_email email
    if user.nil?
      user = User.create(:email => email)
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
