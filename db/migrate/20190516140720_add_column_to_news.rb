class AddColumnToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :DateTime, :string
  end
end
