class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def current_user
    return @current_user if @current_user
    @current_user = User.new
  end

  def only_admin_user
    if not current_user.is_admin?
      flash[:error] = 'Only an administrator can access %{controller}!' % {:controller => params[:controller].to_s.capitalize}
      redirect_to root_path
    end
  end
end
