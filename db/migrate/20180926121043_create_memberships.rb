class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.integer :member_id
      t.integer :project_id

      t.timestamps
    end
    add_index :memberships, :member_id
    add_index :memberships, :project_id
    add_index :memberships, [:member_id, :project_id], unique: true
  end
end
