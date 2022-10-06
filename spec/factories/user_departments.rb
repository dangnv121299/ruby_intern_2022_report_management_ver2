FactoryBot.define do
  factory :user_department do
    name{FFaker::Name.first_name}
  end
end
