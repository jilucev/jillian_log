class ChangeLogToText < ActiveRecord::Migration
  def change
    change_column :outlines, :log, :text
  end
end
