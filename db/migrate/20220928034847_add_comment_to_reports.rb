class AddCommentToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :comment, :string
  end
end
