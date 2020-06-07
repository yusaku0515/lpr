class RenamePostImageColumnToPosts < ActiveRecord::Migration[5.2]
  def change
  	rename_column :posts, :post_image, :post_images
  end
end
