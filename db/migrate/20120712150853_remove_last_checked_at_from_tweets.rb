class RemoveLastCheckedAtFromTweets < ActiveRecord::Migration
  def up
    remove_column :tweets, :last_checked_at
  end

  def down
    add_column :tweets, :last_checked_at, :datetime
  end
end
