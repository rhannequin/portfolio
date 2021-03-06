class Admin::ProjectsController < AdminController

  def index
    @projects = Project.order('position').all
  end

  def new
    @project = Project.new
    @projectsCount = Project.all.size + 1
    @project.position = @projectsCount
    2.times { @project.uploads.build }
  end

  def create
    project = Project.new(params[:project])
    if project.save
      redirect_to admin_projects_path,  flash: {success: 'Project was successfully created'}
    else
      render action: :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    @projectsCount = Project.all.size
    2.times { @project.uploads.build }
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to admin_projects_path,  flash: {success: 'Project was successfully updated'}
    else
      render action: :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      redirect_to admin_projects_path,  flash: {success: 'Project was successfully destroyed'}
    else
      redirect_to action: :index, flash: {error: 'Cannot destroy this project'}
    end
  end

end