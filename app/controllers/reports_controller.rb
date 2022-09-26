class ReportsController < ApplicationController
  before_action :logged_in_user
  before_action :find_report, only: :show

  def show
    @user = @report.user
  end

  def new
    @report = current_user.reports.build
  end

  def create
    @report = current_user.reports.build report_params

    if @report.save
      flash[:info] = t ".create_success_notify"
      redirect_to root_path
    else
      flash.now[:danger] = t ".create_failed_notify"
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit Report::UPDATABLE_ATTRS
  end

  def find_report
    @report = Report.find_by id: params[:id]
    return if @report

    flash[:danger] = t ".find_report"
  end
end
