class RenameUserEventsIsOwnerColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :user_events, :is_owner, :owner
  end
end
