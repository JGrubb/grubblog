class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :body
      t.datetime :last_checked_at

      t.timestamps
    end
  end
end
