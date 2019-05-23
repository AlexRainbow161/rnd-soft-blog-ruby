class RemoveImagePathFromNews < ActiveRecord::Migration[5.2]
  def change
    remove_column :news, :image_path, :string
  end
end
