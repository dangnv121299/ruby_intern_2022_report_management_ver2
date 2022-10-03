module UserDepartmentsHelper
  def list_manager department
    @managers = department.user_departments.manager.pluck(:user_id)
    @users = User.by_id @managers
  end

  def list_member department
    @members = department.user_departments.member.pluck(:user_id)
    @users = User.by_id @members
  end

  def find_managed user
    user.user_departments.manager.pluck(:department_id)
  end

  def check_manager user, report
    find_managed(user).include?(report.department_id)
  end

  def is_manager? user
    user.user_departments.pluck(:role).include?("manager")
  end

  def managed_this_department user, department
    user.user_departments.manager.pluck(:department_id).include?(department.id)
  end

  def role_edit_user_department user, department, flag
    user.admin? || (managed_this_department(user,
                                            department) && flag == :member)
  end
end
