class CreateSubscribes < ActiveRecord::Migration[5.2]
  def change
    create_table :subscribes do |t|
      t.integer :user_id
      t.integer :s_user_id
      t.integer :schedule_interval_days
      t.boolean :active

      t.timestamps
    end
  end
end
