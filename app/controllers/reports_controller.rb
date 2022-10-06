class ReportsController < ApplicationController
  before_action :logged_in_user
  before_action :find_report, only: %i(show edit update)
  before_action :check_owner_report, only: %i(edit update)
  def show
    @user = @report.user
  end

  def new
    @report = current_user.reports.build
  end

  def create
    @report = current_user.reports.build report_params
    if @report.save
      flash[:info] = t ".create_success"
      redirect_to current_user
    else
      flash.now[:danger] = t ".create_fail"
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.js do
        render :edit_report, locals: {action: params[:action]}
      end
    end
  end

  def update
    if @report.update report_params_edit
      redirect_to report_path(id: @report.id)
      flash[:success] = t ".update_success"
    else
      flash.now[:danger] = t ".update_fail"
      render :edit
    end
  end

  private

  def report_params
    params.require(:report).permit Report::UPDATABLE_ATTRS
  end

  def report_params_edit
    if current_user.id == @report.user_id
      params.require(:report).permit Report::UPDATABLE_ATTRS
    else
      params.require(:report).permit Report::UPDATABLE_ATTRS_MANAGER
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

  def sent_email_manager
    @manager_ids = @report.department.user_departments.manager.pluck(:user_id)
    users = User.by_id @manager_ids
    users.each do |user|
      UserMailer.account_notification(@report, user).deliver_now
    end
  end

  def check_owner_report
    return if current_user.id != @report.user_id

    respond_to do |format|
      format.js do
        render :form, locals: {action: params[:action]}
      end
    end
  end
end
