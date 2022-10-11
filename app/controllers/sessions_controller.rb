class SessionsController < ApplicationController
  before_action :find_by_email, only: :create

  def new; end

  def create
    if @user&.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = t ".login_success"
      redirect_to root_path
    else
      flash.now[:danger] = t ".login_fail"
      render :new
    end
  end

  def destroy
    log_out if user_signed_in?
    redirect_to root_path
  end

  private

  def find_by_email
    @user = User.find_by email: params.dig(:session, :email)&.downcase

    return if @user

    flash[:danger] = t ".find_error"
    redirect_to new_user_session_path
  end
end
