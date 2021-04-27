class UserMailer < ApplicationMailer
  def cignup_confirmation(user)
    @user = user
    @greeting = I18n.t('user_mailer.signup_confirmation.greeting')

    mail to: user.email, subject: I18n.t('user_mailer.signup_confirmation.subject')
  end
end
