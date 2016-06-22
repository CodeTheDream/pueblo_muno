class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true, foreign_key: true
      t.string :entree
      t.string :dessert
      t.string :drink
      t.boolean :tallied, default: false

      t.timestamps null: false
    end
  end
end
