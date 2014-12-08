class CreateOutline < ActiveRecord::Migration
  def change
    create_table :outlines do |t|
      t.string :title
      t.string :description
      t.string :tone
      t.string :mood
      t.string :aesthetic
      t.string :beats
        t.timestamps
    end
  end
end
