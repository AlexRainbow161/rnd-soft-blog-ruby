class AddAboutAgeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :about, :string
    add_column :users, :age, :integer
  end
end
