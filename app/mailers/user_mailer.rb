class UserMailer < ApplicationMailer
  def account_notification report, user
    @report = report
    @user = user
    mail to: @user.email, subject: t(".account_notification")
  end

  def respond_report report
    @report = report
    @user = @report.user
    mail to: @user.email, subject: t(".respond_report")
  end
end
