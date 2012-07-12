class AddingDescriptionToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :description, :text
  end

  def down
    remove_column :posts, :description
  end
end
