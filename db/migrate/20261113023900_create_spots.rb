class CreateSpots < ActiveRecord::Migration[8.1]
  def change
    create_table :spots do |t|
      t.references :area, null: false, foreign_key: true
      t.string :name, null: false
      t.string :category, null: false
      t.text :description
      t.string :address
      t.string :access
      t.string :image_url

      t.timestamps
    end
  end
end