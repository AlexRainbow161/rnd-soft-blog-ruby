class FixColumnInTypes < ActiveRecord::Migration[5.2]
  def change
    rename_column :subscribe_types, :type, :_type
  end
end
