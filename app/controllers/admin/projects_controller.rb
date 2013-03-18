class Admin::ProjectsController < AdminController

  def index
    @projects = Project.order('position').all
  end

end