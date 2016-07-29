class RemoveUserReferencesFromEvent < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :events, column: :user_id
    remove_reference :events, :user, index: true
  end
end
