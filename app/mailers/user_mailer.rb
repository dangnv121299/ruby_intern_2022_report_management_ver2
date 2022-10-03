class UserMailer < ApplicationMailer
  def account_notification report
    @report = report
    @manager_id = report.department.user_departments.manager.pluck(:user_id)
    @users = User.by_id @manager_id
    @users.each do |user|
      mail to: user.email, subject: t(".account_notification")
    end
  end

  def respond_report report
    @report = report
    @user = @report.user
    mail to: @user.email, subject: t(".respond_report")
  end
end
