class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @pagy, @reports = pagy Report.by_user_id(current_user.id)
    @reports = Report.by_department_id(find_managed(current_user))
    @pagy, @feed_items = pagy @reports.newest
  end

  def help; end
end
