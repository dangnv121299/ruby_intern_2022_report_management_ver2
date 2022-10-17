class DepartmentsController < ApplicationController
  before_action :load_department, except: %i(index new create)
  load_and_authorize_resource

  def index
    @pagy, @departments = pagy(Department.sort_by_name)
  end

  def new
    @department = Department.new
    respond_to do |format|
      format.js do
        render :form, locals: {action: params[:action]}
      end
    end
  end

  def create
    @department = Department.new department_params
    if @department.save
      flash[:info] = t ".create_success"
      respond_to do |format|
        format.html{redirect_to departments_path}
        format.js
      end
    else
      flash.now[:danger] = t ".create_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @department.update department_params
      redirect_to @department
    else
      render :edit
    end
  end

  def destroy
    if @department.destroy
      flash[:success] = t ".delete_success"
      redirect_to departments_path
    else
      flash[:danger] = t ".delete_fail"
    end
  end

  def show
    @pagy, @users = pagy @department.users
  end

  private

  def department_params
    params.require(:department).permit Department::UPDATABLE_ATTRS
  end

  def load_department
    @department = Department.find(params[:id])
  end
end
