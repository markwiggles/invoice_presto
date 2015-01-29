class ChangeDataTypePriceInItems < ActiveRecord::Migration
  def change

    remove_column :items, :price


    add_column :items, :price, :float


  end
end
