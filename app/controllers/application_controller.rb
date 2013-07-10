class ApplicationController < ActionController::Base
  before_filter :set_locale, :current_user, :prepend
  protect_from_forgery

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def require_js_init
    @require_js_script = ''
    @require_js_params = {}
  end

  def set_require_js(script, params = {})
    @require_js_script = script
    @require_js_params.merge! params
  end

  private
    def prepend
      @title = 'lol'
      @description_page = ''
      @keywords = ''
    end

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
