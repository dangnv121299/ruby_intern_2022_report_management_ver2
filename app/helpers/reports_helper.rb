module ReportsHelper
  def current_department user
    user_member = []
    user.user_departments.each do |user_dep|
      user_member << user_dep.department if user_dep.member?
    end
    user_member.pluck(:name, :id)
  end

  def department_received report
    @receiver = Department.find_by id: report.department_id
  end
end
