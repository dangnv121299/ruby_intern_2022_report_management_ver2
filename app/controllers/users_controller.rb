class UsersController < ApplicationController
  before_action :logged_in_user,
                except: %i(new create)
  before_action :find_user,
                except: %i(new create index)
  before_action :correct_user, only: %i(edit update)

  def index
    @pagy, @users = pagy(User.all, items: Settings.page_10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:info] = t ".create_success"
      log_in @user
      redirect_to root_path
    else
      flash.now[:danger] = t ".create_fail"
      render :new
    end
  end

  def show
    @pagy, @reports = pagy @user.reports
  end

  def edit; end

  def update
    if @user.update user_params
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit User::UPDATABLE_ATTRS
  end

  def correct_user
    return if current_user?(@user)

    flash[:error] = t ".edit_fail"
    redirect_to root_url
  end
end
