class ReportsController < ApplicationController
  before_action :logged_in_user
  before_action :find_report, only: %i(show edit update)

  def show
    @user = @report.user
  end

  def new
    @report = current_user.reports.build
  end

  def create
    @report = current_user.reports.build report_params

    if @report.save
      UserMailer.account_notification(@report).deliver_now
      flash[:info] = t ".create_success_notify"
      redirect_to current_user
    else
      flash.now[:danger] = t ".create_failed_notify"
      render :new
    end
  end

  def edit; end

  def update
    if @report.update report_params
      check_sent_email
      redirect_to report_path(id: @report.id)
      flash[:success] = t ".update_success_report"
    else
      flash.now[:danger] = t ".update_failed_report"
      render :edit
    end
  end

  private

  def report_params
    if check_manager(current_user, @report)
      params.require(:report).permit Report::UPDATABLE_ATTRS_MANAGER
    else
      params.require(:report).permit Report::UPDATABLE_ATTRS
    end
  end

  def find_report
    @report = Report.find_by id: params[:id]
    return if @report

    flash[:danger] = t ".find_report"
  end

  def check_sent_email
    if @current_user.id == @report.user_id
      UserMailer.account_notification(@report).deliver_now
    else
      UserMailer.respond_report(@report).deliver_now
    end
  end
end
