class SendEmailJob < ApplicationJob
  queue_as :default

  def perform user, report
    if user.id == report.user_id
      @manager_ids = report.department.user_departments.manager.pluck(:user_id)
      users = User.by_id @manager_ids
      users.each do |u|
        UserMailer.account_notification(report, u).deliver_now
      end
    else
      UserMailer.respond_report(report).deliver_now
    end
  end
end
