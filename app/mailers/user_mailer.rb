class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: I18n.t("account_activate.subject")
  end

  def password_reset
    @greeting = I18n.t "account_activate.greeting"
    mail to: Settings.configure.email.reset
  end
end
