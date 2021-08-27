require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before do
    @reservation = FactoryBot.build(:reservation)
  end
  
  describe "新規予約機能" do 
    it "全ての値を正しく入力すれば予約できる" do
      expect(@reservation).to be_valid
    end

    it "dayが空だと予約できない" do
      @reservation.day = ""
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include("Day can't be blank")
    end

    it "dayが過去の日付だと予約できない" do
      @reservation.day = Date.today - 1
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include("Day set from today to 3 month after")
    end

    it "dayが3ヶ月以上先の日付だと予約できない" do
      @reservation.day = 3.month.from_now.next_day
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include("Day set from today to 3 month after")
    end

    it "timeが空だと予約できない" do
      @reservation.time=""
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include("Time can't be blank")
    end

    it "timeが指定された時間以外だと予約できない" do
      @reservation.time="10:30"
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include("Time is invalid")
    end

    it "dayとtime両方同じものが既に登録されている場合は、予約できない" do
      @reservation.save
      @another_reservation = FactoryBot.build(:reservation)
      @another_reservation.day = @reservation.day
      @another_reservation.time = @reservation.time
      @another_reservation.valid?
      expect(@another_reservation.errors.full_messages).to include("Day already reserved")
    end

    it "dayのみ同じものが既に登録されていても、予約はできる" do
      @reservation.time = "10:00"
      @reservation.save
      @another_reservation = FactoryBot.build(:reservation)
      @another_reservation.day = @reservation.day
      @another_reservation.time = "11:00"
      expect(@another_reservation).to be_valid
    end

    it "timeのみ同じものが既に登録されていても、予約はできる" do
      @reservation.day = Date.today
      @reservation.save
      @another_reservation = FactoryBot.build(:reservation)
      @another_reservation.day = Date.today + 1
      @another_reservation.time = @reservation.time
      expect(@another_reservation).to be_valid
    end

    it "start_timeが空だと予約できない" do
      @reservation.start_time = ""
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include("Start time can't be blank")
    end

    it "nameが空だと予約できない" do
      @reservation.name = ""
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include("Name can't be blank")
    end

    it "telが空だと登録できない" do
      @reservation.tel = ""
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include("Tel can't be blank")
    end

    it "telが10桁 or 11桁 より少ないと登録できない" do
      @reservation.tel = "03123456"
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include("Tel is invalid")
    end

    it "telが10桁 or 11桁 より多いと登録できない" do
      @reservation.tel = "031234567890"
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include("Tel is invalid")
    end

    it "telが半角英字だと登録できない" do
      @reservation.tel = "090abcdefg"
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include("Tel is not a number")
    end

    it "telが全角だと登録できない" do
      @reservation.tel = "０９０９８７６５４３２"
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include("Tel is not a number")
    end
  end

end
