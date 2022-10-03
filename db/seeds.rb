department = Department.create!(
                name: "Ruby")
d_manager = User.create!(name: "Example User",
  email: "example+10@report.org",
  password: "123456",
  password_confirmation: "123456",
  role: :manager
)
ad = User.create!(name: "Admin",
  email: "admin@report.org",
  password: "123456",
  password_confirmation: "123456",
  role: :admin
)

manager = UserDepartment.create!(
  name: "Example User",
  role: :manager,
  department_id: department.id,
  user_id: d_manager.id
)

10.times do |n|
  name = "User #{n+1}"
  email = "example-#{n+1}@report.org"
  password = "password"
  mem = User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    role: :member
  )
  UserDepartment.create!(
    role: :manager,
    department_id: department.id,
    user_id: mem.id
  )

end
