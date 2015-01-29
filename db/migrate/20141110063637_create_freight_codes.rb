class CreateFreightCodes < ActiveRecord::Migration
  def change
    create_table :freight_codes do |t|

      t.string :name
      t.integer :freight_amt

    end
  end
end
