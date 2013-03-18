class PortfolioController < ApplicationController

  def index
    @projects = Project.order('position').all
  end

  def show
    @project = Project.find(params[:id])
  end

end
