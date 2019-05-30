class AddTypeFieldToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :subscribe_type, :integer
  end
end
