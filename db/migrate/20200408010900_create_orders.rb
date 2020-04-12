class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :type
      t.string :restaurant
      t.string :menu_path
      t.timestamps
    end
    #add_reference :users, :order, foreign_key: true
  end
end
