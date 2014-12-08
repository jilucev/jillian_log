class AddTitleAgain < ActiveRecord::Migration
  def change
    add_column :outlines, :title, :string
  end
end
