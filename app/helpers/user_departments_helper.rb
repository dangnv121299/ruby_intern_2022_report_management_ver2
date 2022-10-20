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

  def list_department_managed user
    Department.by_id(find_managed(user)).distinct
  end

  def list_member_managed user
    UserDepartment.by_department(find_managed(user)).member.distinct.map(&:user)
  end

  def check_manager user, report
    find_managed(user).include?(report.department_id)
  end

  def is_manager? user
    user.user_departments.manager.present?
  end

  def is_member? user
    user.user_departments.member.present?
  end

  def managed_this_department user, department
    user.user_departments.manager.pluck(:department_id).include?(department.id)
  end

  def managed_this_id_department user, department_id
    user.user_departments.manager.pluck(:department_id).include?(department_id)
  end

  def role_edit_user_department user, department, flag
    user.admin? || (managed_this_department(user,
                                            department) && flag == :member)
  end
end
