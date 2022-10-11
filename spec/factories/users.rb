FactoryBot.define do
  factory :user do
    name{FFaker::Name.first_name}
    email{FFaker::Internet.email.downcase}
    password{"123123"}
    password_confirmation{"123123"}
    role{0}
  end
end
