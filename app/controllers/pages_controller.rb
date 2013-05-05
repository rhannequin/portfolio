# encoding: UTF-8

class PagesController < ApplicationController

  before_filter :require_js_init

  def home
    @title = 'Accueil'
    @description_page = 'Page d\'accueil.'
    @keywords = 'hannequin rémy, rémy hannequin, développeur web, développeur php, site, portfolio, web, intégrateur, php, xhtml, css, communication, multimédia, web 2.0';
    projects = Project.where(:priority => :primary).order('position').limit(5)
    set_require_js "pages/home", { :projects => projects.to_json(
      :include => :tags,
      :methods => :upload_link
    )}
  end

  def profile
    @title = 'Profil'
    @description_page = 'Récapitulatif de mes compétences et expériences ainsi que des informations concernant ma formation.'
    @keywords = 'profil, formation, compétences, expériences, personnel'
  end

  def curriculum_vitae
    @title = 'Curriculum vitae'
    @description_page = 'Mon curriculum vitae au format html.'
    @keywords = 'curriculum, vitae, cv, formation, expériences, loisirs, personnel'
  end

  def contact
    @title = 'Contact'
    @message = Message.new
  end

  def send_contact
    @message = Message.new(params[:message])

    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(:contact, :notice => true)
    else
      flash.now.alert = "Veuillez remplir tous les champs"
      render :contact
    end
  end

  def require_js_init
    @require_js_script = ''
    @require_js_params = {}
  end

  def set_require_js(script, params = {})
    @require_js_script = script
    @require_js_params.merge! params
  end

end
