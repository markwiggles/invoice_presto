module Account

  class SettingsController < ApplicationController


    def index
      assign_components
    end

    # -------------------------------------------------------------------------
    # REFRESH THE LIST

    def refresh_content

      assign_components

      respond_to do |format|
        format.html { redirect_to account_settings_path }
        format.js
      end
    end

    # -------------------------------------------------------------------------

    def assign_components
      @billers = Biller.all
      @debtors = Debtor.all
      @items = Item.all
      @tax_codes = TaxCode.all
      @freight_codes = FreightCode.all
      @bank_details = BankDetail.all
    end

  end
end