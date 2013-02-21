class AdminController < ApplicationController
  before_filter :current_user
  before_filter :only_admin_user

  def index
    puts 'lol'
  end
end
