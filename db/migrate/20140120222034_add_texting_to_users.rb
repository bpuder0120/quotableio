class AddTextingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :texting, :boolean, default: true
  end
end
