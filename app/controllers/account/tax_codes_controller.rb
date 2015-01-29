module Account

  class TaxCodesController < ApplicationController

    # -----------------------------------------------
    # CREATE
    def new
      @tax_code = TaxCode.new
    end

    def create
      @tax_code = TaxCode.new(tax_code_params)

      if @tax_code.save
        respond_to do |format|
          format.html { redirect_to account_settings_path }
          format.js {render :js => 'refreshList();'}
        end
      end
    end

    # -----------------------------------------------
    # UPDATE
    def edit
      @tax_code = TaxCode.find params[:id]
    end

    def update
      @tax_code = TaxCode.find params[:id]

      if @tax_code.update_attributes tax_code_params
        respond_to do |format|
          format.html { redirect_to account_settings_path }
          format.js {render :js => 'refreshList();'}
        end
      end
    end

    # -----------------------------------------------
    # DELETE
    def delete
      @tax_code = TaxCode.find params[:id]
    end

    def destroy
      @tax_code = TaxCode.find(params[:id]).destroy
      respond_to do |format|
        format.html { redirect_to account_settings_path }
        format.js
      end

    end

    # -----------------------------------------------
    def tax_code_params

      params.require(:tax_code).permit(
          :name,
          :percent
      )
    end
  end
  # -----------------------------------------------

end