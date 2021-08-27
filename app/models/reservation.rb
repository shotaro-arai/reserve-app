class Reservation < ApplicationRecord

  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/ #10桁 or 11桁のハイフン抜きの電話番号
  VALID_TIME_REGEX = /9:00|10:00|11:00|13:00|14:00|15:00|16:00|17:00|18:00|19:00|20:00/
  with_options presence: true do
    validates :day
    validates :time, format:{with: VALID_TIME_REGEX}
    validates :start_time
    validates :name
    validates :tel, numericality: true, format:{with:VALID_PHONE_REGEX}
  end

  validate :day_term
  validate :day_time_unique
  
  def day_term #過去の日付、また3ヶ月以降の日付では予約できないバリデーション
    if day
      if day < Date.today || 3.month.from_now < day
        errors.add(:day, "set from today to 3 month after")
      end
    end
  end

  def day_time_unique #予約できる日付は重複できないバリデーション
    @reservation = Reservation.where(day: day).where(time: time)
    if @reservation != []
      errors.add(:day, "already reserved")
    end
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
