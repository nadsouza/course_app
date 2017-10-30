class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name

      t.timestamps
    end

    add_index :locations, :id, unique: true
    add_index :locations, :name, unique: true
  end
end
