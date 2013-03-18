class Admin::ProjectsController < AdminController

  def index
    @projects = Project.order('position').all
  end

  def edit
    @project = Project.find(params[:id])
    @projectsCount = Project.all.size
  end

end