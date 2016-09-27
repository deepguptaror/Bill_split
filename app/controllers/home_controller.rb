class HomeController < ApplicationController
  def index
  if admin_signed_in?
    redirect_to users_path
  else
    redirect_to new_admin_session_path
  end  
  end
end
