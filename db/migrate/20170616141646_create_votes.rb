class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.boolean :upvote, null: false
      t.integer :puppy_id, null: false
      t.integer :user_id, null: false
    end

    add_index :votes, [:puppy_id, :user_id], unique: true
  end
end
