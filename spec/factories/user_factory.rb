FactoryBot.define do
  factory :user do
    email { 'user@test.com' }
    password { '$p@ssw0rd' }
  end
end
