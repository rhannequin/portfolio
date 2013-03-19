class AdminController < ApplicationController
  before_filter :only_admin_user, :except => [:login, :authenticate]

  def index
  end

  def login
    redirect_to admin_path if !current_user.nil? and current_user.is_admin?
    render :layout => false
  end

  def authenticate
    return redirect_to admin_path if !current_user.nil? and current_user.is_admin?
    user = params[:user]
    if user[:login] === ENV['ADMIN_LOGIN'] and user[:password] === ENV['ADMIN_PASSWORD']
      self.current_user = User.first
      redirect_to admin_path, flash: { success: 'Hey, %{firstname} %{lastname}!' %
        { :firstname => current_user.firstname,
          :lastname  => current_user.lastname } }
    else
      redirect_to admin_login_path, flash: { error: 'Sorry, these are wrong information.' }
    end
  end
end
