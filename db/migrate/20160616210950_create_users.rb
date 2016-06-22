class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.text :connections
      t.string :connection_other
      t.boolean :complete

      t.timestamps null: false
    end
  end
end
