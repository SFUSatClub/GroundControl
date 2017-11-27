class AddSatellitePreferencesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :preferences, :text
  end
end