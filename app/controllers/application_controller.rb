class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :danger, :warning
  include SessionsHelper
  include ReportsHelper
  include UserDepartmentsHelper
  include Pagy::Backend
  before_action :set_locale

  private

  def check_role? role
    return if current_user.send("#{role}?")

    redirect_to root_path
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include?(locale)
                    locale
                  else
                    I18n.default_locale
                  end
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t ".flash_login"
    redirect_to login_url
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".find_user"
    redirect_to root_path
  end
end
