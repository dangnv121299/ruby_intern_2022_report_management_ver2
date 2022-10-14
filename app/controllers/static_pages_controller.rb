class StaticPagesController < ApplicationController
  def home
    return unless user_signed_in?

    @pagy, @reports = pagy Report.by_user_id(current_user.id)

    @rps = Report.by_department_id(find_managed(current_user))
    @reports = @rps.search(params)
    @pagy, @feed_items = pagy @reports.newest
  end

  def help; end
end
