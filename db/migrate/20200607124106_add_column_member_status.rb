class AddColumnMemberStatus < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :member_status, :boolean, default: true, null: false
  end
end
