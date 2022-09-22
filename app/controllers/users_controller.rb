class UsersController < ApplicationController
  before_action :logged_in_user,
                except: %i(new create)
  before_action :find_user,
                except: %i(new create)

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

  private

  def user_params
    params.require(:user).permit User::UPDATABLE_ATTRS
  end
end
