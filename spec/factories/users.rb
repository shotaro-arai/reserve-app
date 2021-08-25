FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    name { Faker::JapaneseMedia::OnePiece.character }
    tel { Faker::Number.number(digits: 10.11) }
  end
end
