class AddUserIdToProjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :user, foreign_key: true
    add_index :projects, [:user_id, :created_at]
  end
end
