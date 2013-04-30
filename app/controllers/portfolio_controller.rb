# encoding: UTF-8

class PortfolioController < ApplicationController

  layout 'pages'

  def index
    @projects_primary = Project.where(:priority => :primary).order('position').all
    @projects_secondary = Project.where(:priority => :secondary).order('position').all
    @title = ''
    @description_page = 'Liste des travaux effectués.'
    @keywords = 'portfolio, créations, travaux'
  end

  def show
    @project = Project.where(:slug => params[:slug]).first
    @similars = Project.related(@project, @project.tags)
    @title = @project.title
  end

end
