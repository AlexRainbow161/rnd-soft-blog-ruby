class AddColumndToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :user_id, :integer
  end
end
