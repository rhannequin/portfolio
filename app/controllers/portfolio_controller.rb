# encoding: UTF-8

class PortfolioController < ApplicationController

  before_filter :require_js_init

  layout 'pages'

  def index
    @projects_primary = Project.where(:priority => :primary).order('position').all
    @projects_secondary = Project.where(:priority => :secondary).order('position').all
    @title = I18n.t('title.portfolio')
    @description_page = I18n.t('description.portfolio')
    @keywords = [I18n.t('keywords.portfolio'), I18n.t('keywords.projects')].join(', ')
  end

  def show
    @project = Project.where(:slug => params[:slug]).first
    @similars = Project.related(@project, @project.tags)
    @title = @project.title
    set_require_js "portfolio/show"
  end

end
