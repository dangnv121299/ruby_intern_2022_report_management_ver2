class StaticPagesController < ApplicationController
  def home
    return unless user_signed_in?

    @rps = Report.by_department_id(find_managed(current_user))
    @pagy, @feed_items = pagy @rps.newest
  end

  def help; end
end
