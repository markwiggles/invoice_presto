module Account

  class InvoicesController < ApplicationController


    def index
      @invoice = Invoice.new
      assign_components
    end

    # -----------------------------------------------
    # SHOW

    def show
      assign_show_components

      respond_to do |format|
        format.html
        format.pdf do
          render pdf: @invoice_number, # file name
                 template: 'account/invoices/show_pdf.html.erb',
                 layout: 'wicked.pdf.erb', # layout used
                 orientation: 'Portrait',
                 margin: {top: 0, bottom: 0},
                  page_size: 'A4',
                 show_as_html: params[:debug].present?, # allow debuging
                 save_to_file: Rails.root.join('pdfs', "#{@invoice_number}.pdf")
        end
      end
    end

    def mail_pdf

      respond_to do |format|
        format.js
        format.html { redirect_to account_settings_path }
      end

      # PdfMailer.send_mail_to_debtor(params[:invoice]).deliver

    end

    # -----------------------------------------------
    # CREATE
    def new
      @invoice = Invoice.new
    end

    def create
      @invoice = Invoice.new(invoice_params)
      assign_components

      if @invoice.save

        # send to page which will render pdf in iframe
        last_id = Invoice.last.id
        render :js => "window.location = '#{account_invoice_path(last_id)}'"

      else
        render('new')
      end

    end


    # -----------------------------------------------
    # UPDATE
    def edit
      @invoice = Invoice.find params[:id]
    end

    def update
      @invoice = Invoice.find params[:id]
      if @invoice.update_attributes invoice_params
        respond_to do |format|
          format.html { redirect_to account_settings_path }
          format.js
        end
      end
    end

    # -----------------------------------------------
    # DELETE
    def delete
      @invoice = Invoice.find params[:id]
    end

    def destroy
      @invoice = Invoice.find(params[:id]).destroy
      respond_to do |format|
        format.html { redirect_to account_settings_path }
        format.js
      end
    end

    # -------------------------------------------------------------------------
    # REFRESH THE IMAGE

    def refresh_image
      @logo = Logo.find params[:id]

      respond_to do |format|
        format.html { redirect_to account_invoices_path }
        format.js
      end
    end

    # -------------------------------------------------------------------------
    # REFRESH THE BILLER

    def refresh_biller
      @biller = Biller.find params[:id]

      respond_to do |format|
        format.html { redirect_to account_invoices_path }
        format.js
      end
    end

    # -------------------------------------------------------------------------
    # REFRESH THE DEBTOR

    def refresh_debtor
      @debtor = Debtor.find params[:id]

      respond_to do |format|
        format.html { redirect_to account_invoices_path }
        format.js
      end
    end
    # -------------------------------------------------------------------------
    # REFRESH THE ITEM

    def refresh_item
      @item = Item.find params[:id]

      respond_to do |format|
        format.html { redirect_to account_invoices_path }
        format.js
      end
    end
    # -------------------------------------------------------------------------
    # REFRESH TAX CODE

    def refresh_tax_code
      @tax_code = TaxCode.find params[:id]

      logger.debug "TAX CODE #{@tax_code.percent}"

      respond_to do |format|
        format.html { redirect_to account_invoices_path }
        format.js
      end
    end
    # -------------------------------------------------------------------------
    # REFRESH FREIGHT CODE

    def refresh_freight_code
      @freight_code = FreightCode.find params[:id]

      respond_to do |format|
        format.html { redirect_to account_invoices_path }
        format.js
      end
    end


    # -------------------------------------------------------------------------
    # REFRESH THE BANK DETAILS

    def refresh_bank_details
      @bank_detail = BankDetail.find params[:id]

      respond_to do |format|
        format.html { redirect_to account_invoices_path }
        format.js
      end
    end

    # -------------------------------------------------------------------------
    def invoice_params

      params.require(:invoice).permit(
          :date,
          :invoice_number,
          :amount,
          :billers_id,
          :debtors_id,
          :items_id,
          :qty,
          :tax_codes_id,
          :freight_codes_id,
          :bank_details_id
      )
    end

    # -----------------------------------------------

    def assign_components
      @date = Date.today.strftime('%B %d %Y')
      @billers = Biller.all
      @debtors = Debtor.all
      @items = Item.all
      @tax_codes = TaxCode.all
      @freight_codes = FreightCode.all
      @bank_details = BankDetail.all
    end

    # -----------------------------------------------

    def assign_show_components

      @invoice = Invoice.find_by_id params[:id]

      @date = Date.today.strftime('%B %d %Y')
      @invoice_number = @invoice.invoice_number

      @biller = Biller.find_by_id @invoice.billers_id
      @debtor = Debtor.find_by_id @invoice.debtors_id
      @item = Item.find_by_id @invoice.items_id
      @tax_code = TaxCode.find_by_id @invoice.tax_codes_id
      @freight_code = FreightCode.find_by_id @invoice.freight_codes_id

      @bank_detail = BankDetail.find_by @invoice.bank_details_id


    end



  end
end