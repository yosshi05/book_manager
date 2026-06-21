class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :status
      t.integer :progress
      t.text :memo

      t.timestamps
    end
  end
end
