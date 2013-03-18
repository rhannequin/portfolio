class CreateProjectsTagsTable < ActiveRecord::Migration
  def up
    create_table :projects_tags, :id => false do |t|
      t.references :tag, :null => false
      t.references :project, :null => false
    end
  end

  def down
    drop_table :projects_tags
  end
end
