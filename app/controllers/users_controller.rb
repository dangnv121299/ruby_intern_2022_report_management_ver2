class UsersController < ApplicationController
  before_action :logged_in_user,
                except: %i(new create)
  before_action :find_user,
                except: %i(new create index)
  before_action :check_edit_role, only: %i(edit update)
  before_action :check_create_role, only: %i(new create destroy)

  def index
    @pagy, @users = pagy(User.sort_by_name, items: Settings.page_10)
  end

  def new
    @user = User.new
    @user.user_departments.build
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:info] = t ".create_success"
      redirect_to @user
    else
      flash.now[:danger] = t ".create_fail"
      render :new
    end
  end

  def show
    if current_user.manager? || @user == current_user
      @pagy, @reports = pagy @user.reports.sort_by_time
    else
      @reports = []
    end
  end

  def edit; end

  def update
    if @user.update user_params
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_fail"
    end
  end

  private

  def user_params
    if is_manager? current_user
      params.require(:user).permit User::UPDATABLE_ATTRS_MANAGER,
                                   user_departments_attributes:
                                   UserDepartment::UPDATABLE_ATTRS
    else
      params.require(:user).permit User::UPDATABLE_ATTRS
    end
  end

  def check_edit_role
    return if current_user?(@user) || is_manager?(current_user)

    flash[:error] = t ".edit_fail"
    redirect_to root_path
  end

  def check_create_role
    return if is_manager?(current_user) || current_user.admin?

    flash[:error] = t ".create_fail"
    redirect_to root_path
  end
end
