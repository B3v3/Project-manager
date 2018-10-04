class AddIndexToUsersAndProjects < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :name, unique: true
    add_index :projects,[:title], unique: true
  end
end
