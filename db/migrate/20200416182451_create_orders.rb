class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :type
      t.string :resturant
      t.string :menu_image
      t.text :food
      t.belongs_to :user
      
      t.timestamps
    end
  end
end
