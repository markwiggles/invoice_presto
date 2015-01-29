module Account

  class BankDetailsController < ApplicationController

    # -----------------------------------------------
    # CREATE
    def new
      @bank_detail = BankDetail.new
    end

    def create
      @bank_detail = BankDetail.new(bank_detail_params)

      if @bank_detail.save
        respond_to do |format|
          format.html {redirect_to account_settings_path}
          format.js {render :js => 'refreshList();'}
        end
      end
    end
    # -----------------------------------------------
    # UPDATE
    def edit
      @bank_detail = BankDetail.find params[:id]
    end

    def update
      @bank_detail = BankDetail.find params[:id]
      if @bank_detail.update_attributes bank_detail_params
        respond_to do |format|
          format.html {redirect_to account_settings_path}
          format.js {render :js => 'refreshList();'}
        end
      end
    end

    # -----------------------------------------------
    # DELETE
    def delete
      @bank_detail = BankDetail.find params[:id]
    end

    def destroy
      @bank_detail = BankDetail.find(params[:id]).destroy
      respond_to do |format|
        format.html { redirect_to account_settings_path }
        format.js
      end

    end

    # -----------------------------------------------
    def bank_detail_params

      params.require(:bank_detail).permit(
          :bsb,
          :account_number,
          :account_name
      )
    end
  end
  # -----------------------------------------------

end
