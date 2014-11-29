class AddUserIdtoOutlines < ActiveRecord::Migration
  def change
    add_column :outlines, :user_id, :integer
    add_index :outlines, [:user_id, :created_at]
  end
end