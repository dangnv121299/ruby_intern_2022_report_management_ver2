department = Department.create!(
                name: "Ruby")
User.create!(name: "Example User",
  email: "example+10@report.org",
  password: "123456",
  password_confirmation: "123456",
  role: :manager
)
manager = UserDepartment.create!(
  name: "Example User",
  role: :manager,
  department_id: department.id
)
99.times do |n|
  name = "User #{n+1}"
  email = "example-#{n+1}@report.org"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    role: :member,
    user_department_id: manager.id
  )
end
users = User.order(:created_at).take(6)
  50.times do |n|
  content = "example-#{n+1}@report.org"
  users.each { |user| user.reports.create!(
      plan_today: content,
      reality: content,
      reason: content,
      plan_next_day: content
    )
  }
end
