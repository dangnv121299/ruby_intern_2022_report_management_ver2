class StaticPagesController < ApplicationController
  def home
    return unless user_signed_in?

    @rps = Report.includes(:user).by_department_id(find_managed(current_user))
    @pagy, @feed_items = pagy(@rps.newest, items: Settings.page_7)
  end

  def help; end
end
