class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    project = Project.new(params[:project])
    if @project.save
      redirect_to @project,  flash: {success: _('Project was successfully created')}
    else
      render action: :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project,  flash: {success: _('Project was successfully updated')}
    else
      render action: :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      redirect_to @project,  flash: {success: _('Project was successfully destroyed')}
    else
      redirect_to action: :index, flash: {error: _('Cannot destroy this project')}
    end
  end

end
