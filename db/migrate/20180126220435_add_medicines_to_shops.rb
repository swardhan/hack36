class AddMedicinesToShops < ActiveRecord::Migration[5.1]
  def change
    create_table :medicines_shops, id: false do |t|
      t.belongs_to :shop, index: true
      t.belongs_to :medicine, index: true
    end
  end
end
