class AddColumnReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :name, :string
    add_column :reservations, :tel, :integer
  end
end
