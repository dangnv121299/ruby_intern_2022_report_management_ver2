FactoryBot.define do
  factory :department do
    name{FFaker::Name.unique.first_name}
  end
end
