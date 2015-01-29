class ChangeFreightColumn < ActiveRecord::Migration
  def change

    remove_column :freight_codes, :freight_amt

    add_column :freight_codes, :rate, :float


  end
end
