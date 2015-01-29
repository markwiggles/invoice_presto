class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|


      t.string   :date
      t.string   :invoice_number
      t.integer  :amount

      t.references :billers, index: true
      t.references :debtors, index: true
      t.references :items, index: true
      t.references :tax_codes, index: true
      t.references :freight_codes, index: true
      t.references :bank_details, index: true


      t.timestamps

    end
  end
end
