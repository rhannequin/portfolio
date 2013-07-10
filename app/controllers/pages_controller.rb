# encoding: UTF-8

class PagesController < ApplicationController

  before_filter :require_js_init

  def home

    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token = ENV['TWITTER_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
      config.connection_options = Twitter::Default::CONNECTION_OPTIONS.merge(
        :request => {
          :open_timeout => 5,
          :timeout => 20
        }
      )
    end

    timeline = Twitter.user_timeline 'rhannequin', :count => 30

    @title = I18n.t('title.home')
    @description_page = I18n.t('description.home')
    @keywords = 'hannequin rémy, rémy hannequin, développeur web, développeur php, site, portfolio, web, intégrateur, php, xhtml, css, communication, multimédia, web 2.0';
    projects = Project.where(:priority => :primary).order('position').limit(5)
    set_require_js "pages/home", {
      :projects => projects.to_json(
        :include => :tags,
        :methods => :upload_link
      ),
      :tweets => timeline.to_json
    }
  end

  def about
    @title = I18n.t('title.profile')
    @description_page = I18n.t('description.profile')
    @keywords = [
      I18n.t('keywords.profile'), I18n.t('keywords.school'), I18n.t('keywords.skills'),
      I18n.t('keywords.experience'), I18n.t('keywords.personal')
    ].join(', ')
  end

  def curriculum_vitae
    @title = I18n.t('title.curriculumvitae')
    @description_page = I18n.t('description.cv')
    @keywords = [
      I18n.t('keywords.curriculum'), I18n.t('keywords.vitae'), I18n.t('keywords.cv'),
      I18n.t('keywords.school'), I18n.t('keywords.experience'), I18n.t('keywords.hobbies'),
      I18n.t('keywords.personal')
    ].join(', ')
  end

  def sitemap
    @title = 'Plan du site'
    @description_page = 'Plan du site.'
    @keywords = 'plan, site, navigation'
  end

  def accessibility
    @title = "Politique d'accessibilité"
    @description_page = 'Liste des raccourcis clavier (accesskey) disponibles sur le site.'
    @keywords = 'accessibilité, handicap, w3c, ergonomie, ergonome, accessible, accesskey, raccourcis clavier'
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

end
