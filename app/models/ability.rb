class Ability
  include CanCan::Ability
  include UserDepartmentsHelper

  def initialize user, params = nil
    return if user.blank?

    if user.admin?
      can :manage, :all
    else
      can %i(read create update), Report, user_id: user.id
      can %i(read update), User, id: user.id
      can :read, Department
      if is_manager? user
        can :create, User
        can %i(read update), Report do |report|
          check_manager(user, report) == true
        end
        if managed_this_id_department(user, params[:id])
          can :create, UserDepartment, department_id: params[:id]
        end
      end
    end
  end
end
