class FixFieldsInLikes < ActiveRecord::Migration[5.2]
  def change
    change_column :likes, :news_id, :integer
    change_column :likes, :user_id, :integer
  end
end
