class RenameTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :mail_intevals, :mail_intervals
    rename_column :users, :mail_inteval_id, :mail_interval_id
  end
end
