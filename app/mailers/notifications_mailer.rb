class NotificationsMailer < ActionMailer::Base

  default :from => ENV['EMAIL_DOMAIN']
  default :to   => ENV['EMAIL_DOMAIN']

  def new_message(message)
    @message = message
    mail(:subject => "[#{ENV['EMAIL_HOST']}] Prise de contact")
  end

end