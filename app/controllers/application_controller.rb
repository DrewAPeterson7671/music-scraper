class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :is_admin?

  def is_admin?
    current_user && current_user.admin
  end
  
end
