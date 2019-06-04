class StillTryFixColumnTypesInLikes < ActiveRecord::Migration[5.2]
  def change
    drop_table :likes
    create_table :likes do |t|
      t.integer :user_id
      t.integer :news_id
    end
  end
end
