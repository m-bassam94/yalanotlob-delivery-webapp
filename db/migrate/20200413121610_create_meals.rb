class CreateMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :meals do |t|
      t.string :person
      t.string :meal
      t.integer :amount
      t.integer :price
      t.text :comment
      t.integer :order

      t.timestamps
    end
  end
end
