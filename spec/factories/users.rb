FactoryBot.define do
  factory :user do
    password { 'testuser' }
    name { 'testuser' }
    sequence(:email) { |n| "test#{n}@example.com" }
    sex { 3 }
    birth_date { Date.new(1989, 1, 1) }
    animal { 'イヌ' }
  end
end
