class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|

      t.integer :user_id
      t.integer :local_id
      t.string :title
      t.text :post_text
      t.string :post_image
      t.float :star

      t.timestamps
    end
  end
end
