class FixColumnsInUser < ActiveRecord::Migration[5.2]
  def change
    #rename_column :users, :mail_inteval_id, :mail_interval_id
    #rename_column :users, :subscribe_type, :subscribe_type_id
    rename_table :mail_inteval, :mail_intervals
  end
end
