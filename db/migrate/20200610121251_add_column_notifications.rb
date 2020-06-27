class AddColumnNotifications < ActiveRecord::Migration[5.2]
  def change
  	  add_column :notifications, :visiter_id, :integer
  	  add_column :notifications, :visited_id, :integer
  end
end
