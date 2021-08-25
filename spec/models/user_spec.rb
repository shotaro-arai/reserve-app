require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
    
  describe "ユーザー新規登録" do
    it "全ての入力項目を正しく入力できていれば、登録できる" do
      expect(@user).to be_valid
    end
  
    it "emailが空だと登録できない" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "emailに @ がないと登録できない" do
      @user.email = "abc.com"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "emailが全角だと登録できない" do
      @user.email = "エービーシードットコム"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "passwordが空だと登録できない" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
  
    it "passwordが6文字より少ないと登録できない" do
      @user.password = "12345"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "password_confirmationが空だと登録できない" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "password_confirmationがpasswordと一致しないと登録できない" do
      @user.password = "123456"
      @user.password_confirmation = "123457"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "nameが空だと登録できない" do
      @user.name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it "telが空だと登録できない" do
      @user.tel = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Tel can't be blank")
    end

    it "telが10桁 or 11桁 より少ないと登録できない" do
      @user.tel = "03123456"
      @user.valid?
      expect(@user.errors.full_messages).to include("Tel is invalid")
    end

    it "telが10桁 or 11桁 より多いと登録できない" do
      @user.tel = "031234567890"
      @user.valid?
      expect(@user.errors.full_messages).to include("Tel is invalid")
    end

    it "telが半角英字だと登録できない" do
      @user.tel = "090abcdefg"
      @user.valid?
      expect(@user.errors.full_messages).to include("Tel is not a number")
    end

    it "telが全角だと登録できない" do
      @user.tel = "０９０９８７６５４３２"
      @user.valid?
      expect(@user.errors.full_messages).to include("Tel is not a number")
    end
  end
end
