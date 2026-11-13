class CreateWishes < ActiveRecord::Migration[8.1]
  def change
    create_table :wishes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :spot, null: false, foreign_key: true

      t.timestamps
    end
    add_index :wishes, [:user_id, :spot_id], unique: true
  end
end