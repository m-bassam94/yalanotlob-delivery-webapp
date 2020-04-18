class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name ,null: false , unique: true
      
       t.bigint :creator ,null: false 

      t.timestamps
    end
  end
end