class ChangeDatatypeAreaNameOfLocals < ActiveRecord::Migration[5.2]
  def change
  	change_column :locals, :area_name, :integer
  end
end
