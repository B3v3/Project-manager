class AddUserIdToTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :user, foreign_key: true
    add_index :tasks, [:user_id, :created_at]
  end
end
