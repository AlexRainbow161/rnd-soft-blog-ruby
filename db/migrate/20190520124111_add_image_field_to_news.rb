class AddImageFieldToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :image_path, :string
  end
end
