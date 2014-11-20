class RemoveUneededColumnsOnOutlines < ActiveRecord::Migration
  def change
    remove_column :outlines, :title, :date 
    rename_column :outlines, :description, :log
    remove_column :outlines, :tone
    remove_column :outlines, :mood
    remove_column :outlines, :aesthetic
    remove_column :outlines, :beats
  end
end