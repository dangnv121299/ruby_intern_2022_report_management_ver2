FactoryBot.define do
  factory :report do
    status{0}
    plan_today{FFaker::Lorem.sentence(word_count = 20)}
    reality{FFaker::Lorem.sentence(word_count = 20)}
    reason{FFaker::Lorem.sentence(word_count = 20)}
    plan_next_day{FFaker::Lorem.sentence(word_count = 20)}
    department {FactoryBot.create :department}
    department_id {department.id}
  end
end
