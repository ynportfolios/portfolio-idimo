FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    name { 'testuser' }
    animal { 'イヌ' }
    sex { 3 }
    birth_date { Date.new(1989, 1, 1) }
    password { 'testuser' }
  end
end

FactoryBot.define do
  factory :user_a, class: User do
    email { 'test_a@example.com' }
    name { 'testuser_a' }
    animal { 'イヌ' }
    sex { 3 }
    birth_date { Date.new(1989, 1, 1) }
    password { 'testuser_a' }
  end
end

FactoryBot.define do
  factory :user_b, class: User do
    email { 'test_b@example.com' }
    name { 'testuser_b' }
    animal { 'ネコ' }
    sex { 2 }
    birth_date { Date.new(1980, 1, 1) }
    password { 'testuser_b' }
  end
end
