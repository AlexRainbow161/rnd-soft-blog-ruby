class CreateMailIntevals < ActiveRecord::Migration[5.2]
  def change
    create_table :mail_intevals do |t|
      t.string :name
      t.integer :interval

      t.timestamps
    end
  end
end
