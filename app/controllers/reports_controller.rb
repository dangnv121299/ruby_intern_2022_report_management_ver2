class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_report, except: %i(new create index)
  before_action :check_owner_report, only: %i(edit)
  load_and_authorize_resource

  def index
    @search = Report.ransack(params[:search],
                             auth_object: set_ransack_auth_object)
    @reports = @search.result.includes(:user, :department)
    @pagy, @feed_items = pagy(
      @reports.by_department_id(find_managed(current_user)),
      items: Settings.page_5
    )
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

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
      SendEmailJob.perform_later(current_user, @report)
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
      SendEmailJob.perform_later(current_user, @report)
    else
      flash.now[:danger] = t ".update_fail"
      render :edit
    end
  end

  private

  def set_ransack_auth_object
    current_user.admin? ? :admin : :user
  end

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
    redirect_to root_path
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
