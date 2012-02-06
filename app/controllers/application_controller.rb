class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include SessionsHelper
  
  def authenticate
    deny_access unless sign_in?
  end
end
