class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :phone, null: false
      t.string :category
    end
  end
end
