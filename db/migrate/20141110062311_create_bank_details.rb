class CreateBankDetails < ActiveRecord::Migration
  def change
    create_table :bank_details do |t|
      t.string :bsb
      t.string :account_number
      t.string :account_name

      t.timestamps
    end
  end
end