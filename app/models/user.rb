class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/ #10桁 or 11桁のハイフン抜きの電話番号
  validates :name, presence: true
  validates :tel, presence: true, numericality: true, format:{with:VALID_PHONE_REGEX}
end
