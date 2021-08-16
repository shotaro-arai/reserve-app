class Reservation < ApplicationRecord

  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/ #10桁 or 11桁のハイフン抜きの電話番号
  with_options presence: true do
    validates :day
    validates :start_time
    validates :name
    validates :tel, numericality: true, format:{with:VALID_PHONE_REGEX}
  end
  
  def self.reservations_after_three_month
    # 今日から3ヶ月先までのデータを取得
    reservations = Reservation.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
    # 配列を作成し、データを格納
    # DBアクセスを減らすために必要なデータを配列にデータを突っ込んでます
    reservation_data = []
    reservations.each do |reservation|
      reservations_hash = {}
      reservations_hash.merge!(day: reservation.day.strftime("%Y-%m-%d"), time: reservation.time)
      reservation_data.push(reservations_hash)
    end
    reservation_data
  end

end
