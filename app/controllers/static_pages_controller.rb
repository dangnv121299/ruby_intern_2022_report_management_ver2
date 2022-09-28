class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @report = current_user.reports.build
    @pagy, @feed_items = pagy current_user.feed
  end

  def help; end
end
