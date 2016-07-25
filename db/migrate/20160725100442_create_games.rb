class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :name
      t.text :description
      t.integer :min_players
      t.integer :max_players

      t.timestamps
    end
  end
end
