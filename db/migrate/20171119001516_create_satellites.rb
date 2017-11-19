class CreateSatellites < ActiveRecord::Migration[5.1]
  def change
    create_table :satellites do |t|
      t.string :name
      t.text :category
      t.text :tle1
      t.text :tle2

      t.timestamps
    end
  end
end
