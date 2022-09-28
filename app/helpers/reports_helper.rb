module ReportsHelper
  def current_department user
    user.departments.pluck(:name, :id)
  end
end
