class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.text :connections
      t.string :connection_other
      t.string :language
      t.boolean :complete

      t.timestamps null: false
    end
  end
end
