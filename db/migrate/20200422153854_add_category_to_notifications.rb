class AddCategoryToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :category, :integer
  end
end
