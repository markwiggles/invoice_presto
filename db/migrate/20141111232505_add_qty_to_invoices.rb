class AddQtyToInvoices < ActiveRecord::Migration
  def change

    add_column :invoices, :qty, :integer

  end
end
