class ApplicationController < ActionController::Base
  before_filter :current_user
  protect_from_forgery

  private
    def current_user=(usr)
      session[:user] = usr
    end

    def current_user
      return @current_user if @current_user
      return @current_user = session[:user] unless session[:user].nil?
      @current_user = session[:user] = nil
    end
    helper_method :current_user

    def only_admin_user
      if current_user.nil? or !current_user.is_admin?
        redirect_to admin_login_path, flash: { error: 'Only administrators can access this page.' }
      end
    end
end
