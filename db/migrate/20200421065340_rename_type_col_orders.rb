class RenameTypeColOrders < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :type, :category
  end
end
