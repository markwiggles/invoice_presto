class CreateDebtors < ActiveRecord::Migration
  def change
    create_table :debtors do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :town
      t.string :postcode
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
