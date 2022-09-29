class UserMailer < ApplicationMailer
  def account_notification user
    @user = user
    mail to: user.email, subject: t(".account_notification")
  end
end
