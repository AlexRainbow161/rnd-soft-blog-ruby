class AddTypeToSubscribeTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :subscribe_types, :type, :string
  end
end
