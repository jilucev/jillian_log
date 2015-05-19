class AddColorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :color, :string, default: 'white'
  end
end
