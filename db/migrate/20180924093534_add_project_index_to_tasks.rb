class AddProjectIndexToTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :project, foreign_key: true
    add_index :tasks, [:project_id, :created_at]
  end
end
