class ChangeDailyReportsToReports < ActiveRecord::Migration[6.1]
  def change
    rename_table :daily_reports, :reports
  end
end
