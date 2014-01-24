class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :body, null: false
      t.string :author
      t.string :category
      t.timestamps
    end
  end
end
