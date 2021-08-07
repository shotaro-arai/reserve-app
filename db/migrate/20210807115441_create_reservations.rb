class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.timestamps
      t.date "day", null: false
      t.string "time", null: false
      t.datetime "start_time", null: false
    end
  end
end
