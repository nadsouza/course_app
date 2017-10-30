class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email

      t.timestamps
    end

    add_index :users, :id, unique: true
    add_index :users, :email, unique: true
  end
end
