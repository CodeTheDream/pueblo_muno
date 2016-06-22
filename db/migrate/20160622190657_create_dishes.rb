class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :priority
      t.string :reach
      t.string :name
      t.integer :price
      t.integer :votes, default: 0
    end
  end
end
