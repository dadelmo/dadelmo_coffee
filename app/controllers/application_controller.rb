class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include SessionsHelper
  
  def authenticate
    deny_access unless sign_in?
  end

  def index
    redirect_to signin_path
  end

end
