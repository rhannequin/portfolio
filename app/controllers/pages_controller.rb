# encoding: UTF-8

class PagesController < ApplicationController

  def home
    @title = 'Accueil'
    @description_page = 'Page d\'accueil.'
    @keywords = 'hannequin rémy, rémy hannequin, développeur web, développeur php, site, portfolio, web, intégrateur, php, xhtml, css, communication, multimédia, web 2.0';
  end

  def profile
    @title = 'Profil'
    @description_page = 'Récapitulatif de mes compétences et expériences ainsi que des informations concernant ma formation.'
    @keywords = 'profil, formation, compétences, expériences, personnel'
  end

end
