class AddAddressToShops < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :address, :text
  end
end
