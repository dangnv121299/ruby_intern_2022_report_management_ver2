class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @pagy, @reports = pagy Report.by_user_id(current_user.id)
    @pagy, @feed_items = pagy current_user.feed
  end

  def help; end
end
