class AdminController < ApplicationController
  before_filter :only_admin_user

  def index
  end
end
