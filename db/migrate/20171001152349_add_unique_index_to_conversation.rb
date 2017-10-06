class AddUniqueIndexToConversation < ActiveRecord::Migration[5.1]
  def change
    add_index :conversations, [:author_id, :receiver_id], unique: true
  end
end
