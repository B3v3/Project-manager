class AddInviteToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :invite_digest, :string
  end
end
