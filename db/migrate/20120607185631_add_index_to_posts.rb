class AddIndexToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :slug, :string
    add_index :posts, :slug, unique: true
  end
  
  def down
    remove_column :posts, :slug
    remove_index :posts, :slug
  end
  
end
