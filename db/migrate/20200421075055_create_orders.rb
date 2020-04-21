class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :orderType
      t.string :resturant
      t.binary :menu
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
