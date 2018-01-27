class AddFieldsToShops < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :shops, :lon, :decimal, {:precision=>10, :scale=>6}
    add_column :shops, :name, :string
  end
end
