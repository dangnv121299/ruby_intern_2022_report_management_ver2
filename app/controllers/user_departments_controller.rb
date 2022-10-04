class UserDepartmentsController < ApplicationController
  before_action :find_department
  before_action :logged_in_user,
                except: %i(new create)
  before_action :find_user, only: %i(create)
  before_action :find_user_department, except: %i(new create)
  before_action :check_role_manager

  def new
    @user_department = @department.user_departments.build
  end

  def create
    users_department = []
    params[:user_ids].each do |user_id|
      users_department << @department.user_departments.build(user_id: user_id)
    end

    ActiveRecord::Base.transaction do
      users_department.map(&:save!)
      redirect_to department_url(id: params[:department_id])
    end
  end

  def edit; end

  def update
    if @user_department.update user_department_params
      flash[:success] = t ".update_manager"
      redirect_to department_url(id: params[:department_id])
    else
      flash.now[:danger] = t ".update_fail"
      render :edit
    end
  end

  def destroy
    if @user_department.destroy_all
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_fail"
    end
    redirect_to department_url(id: params[:department_id])
  end

  private

  def user_department_params
    if @current_user.admin?
      params.permit UserDepartment::UPDATABLE_ATTRS_ADMIN
    else
      params.permit UserDepartment::UPDATABLE_ATTRS
    end
  end

  def find_department
    @department = Department.find_by id: params[:department_id]
    return if @department

    flash[:danger] = t ".find_department"
  end

  def find_user_department
    @user_deps = UserDepartment.by_department(params[:department_id])
    @user_department = @user_deps.by_user(params[:id])

    return if @user_department

    flash[:danger] = t ".find_user_department"
  end

  def check_role_manager
    list_manager(@department).include?(@current_user) || current_user.admin?
  end
end
