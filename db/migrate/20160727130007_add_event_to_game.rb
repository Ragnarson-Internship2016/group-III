class AddEventToGame < ActiveRecord::Migration[5.0]
  def change
    add_reference :games, :event, foreign_key: true
  end
end
