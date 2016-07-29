class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :city
      t.string :address
      t.datetime :start_t
      t.datetime :end_t
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
