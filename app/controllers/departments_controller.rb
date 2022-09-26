class DepartmentsController < ApplicationController
  before_action ->{check_role? :admin}
  before_action :load_department, only: :show

  def index
    @pagy, @departments = pagy(Department.sort_by_name)
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new department_params
    if @department.save
      flash[:info] = t ".create_success"
      redirect_to @department
    else
      flash.now[:danger] = t ".create_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @department.update department_params
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @department.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_fail"
    end
  end

  def show
    @pagy, @users = pagy @department.users
    @pagy, @user_departments = pagy(User.all, items: Settings.page_10)
  end

  private

  def department_params
    params.require(:department).permit Department::UPDATABLE_ATTRS
  end

  def load_department
    @department = Department.find(params[:id])
  end
end