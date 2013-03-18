class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.text :content
      t.enum :priority # {:primary, :secondary}
      t.integer :position
      t.boolean :published

      t.timestamps
    end

    add_index :projects, :slug
  end
end
