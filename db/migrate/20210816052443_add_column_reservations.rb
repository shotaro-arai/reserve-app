class AddColumnReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :name, :string
    add_column :reservations, :tel, :string #:integerだと、先頭の数字が0の場合エラーとなるため、:stringに修正
  end
end
