class RemoveAvatarPathFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :avatar_path, :string
  end
end
