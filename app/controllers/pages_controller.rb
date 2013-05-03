# encoding: UTF-8

class PagesController < ApplicationController

  def home
    @title = I18n.t('title.home')
    @description_page = I18n.t('description.home')
  end

  def profile
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

end
