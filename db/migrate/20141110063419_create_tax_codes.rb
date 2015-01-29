class CreateTaxCodes < ActiveRecord::Migration
  def change
    create_table :tax_codes do |t|

      t.string :name
      t.integer :percent

    end
  end
end
