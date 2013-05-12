# encoding: UTF-8

class PortfolioController < ApplicationController

  before_filter :require_js_init

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
    set_require_js "portfolio/show"
  end

end
