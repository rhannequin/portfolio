# encoding: UTF-8

class PortfolioController < ApplicationController

  layout 'pages'

  def index
    @projects_primary = Project.where(:priority => :primary).order('position').all
    @projects_secondary = Project.where(:priority => :secondary).order('position').all
    @title = ''
  end

  def show
    @project = Project.find(params[:id])
  end

end
