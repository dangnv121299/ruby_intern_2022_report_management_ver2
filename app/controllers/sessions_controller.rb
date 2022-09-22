class SessionsController < ApplicationController
  before_action :find_by_email, only: :create

  def new; end

  def create
    if @user&.authenticate(params[:session][:password])
      log_in @user
      redirect_to root_path
    else
      flash.now[:danger] = t ".flash_danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def find_by_email
    @user = User.find_by email: params.dig(:session, :email)&.downcase

    return if @user

    flash[:danger] = t ".find_error"
    redirect_to login_url
  end
end
