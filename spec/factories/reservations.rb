FactoryBot.define do
  factory :reservation do
    day{Faker::Date.between(from: Date.today, to: 3.month.from_now)}
    time{["9:00", "10:00", "11:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00"].sample}
    start_time{Faker::Time.between(from: Date.today, to: 3.month.from_now)}
    name{Faker::JapaneseMedia::OnePiece.character}
    tel{Faker::Number.number(digits: 10.11)}
  end
end
