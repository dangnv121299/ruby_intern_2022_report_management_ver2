class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user,
                except: %i(new create index)
  load_and_authorize_resource

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
      redirect_to root_path
    else
      flash.now[:danger] = t ".create_fail"
      render :new
    end
  end

  def show
    if current_user.manager? || @user == current_user
      @pagy, @reports = pagy(@user.reports.sort_by_time, items: Settings.page_6)
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
end
