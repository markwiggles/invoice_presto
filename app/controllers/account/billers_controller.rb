module Account

  class BillersController < ApplicationController

    # -----------------------------------------------
    # CREATE
    def new
      @biller = Biller.new
    end

    def create
      @biller = Biller.new(biller_params)

      if @biller.save
        respond_to do |format|
          format.html { redirect_to account_settings_path }
          format.js {render :js => 'refreshList();'}
        end
      end
    end

    # -----------------------------------------------
    # UPDATE
    def edit
      @biller = Biller.find params[:id]
    end

    def update
      @biller = Biller.find params[:id]

      if @biller.update_attributes biller_params
        respond_to do |format|
          format.html { redirect_to account_settings_path }
          format.js {render :js => 'refreshList();'}
        end
      end
    end

    # -----------------------------------------------
    # DELETE
    def delete
      @biller = Biller.find params[:id]
    end

    def destroy
      @biller = Biller.find(params[:id]).destroy
      respond_to do |format|
        format.html { redirect_to account_settings_path }
        format.js
      end

    end

    # -----------------------------------------------
    def biller_params

      params.require(:biller).permit(
          :name,
          :address1,
          :address2,
          :town,
          :postcode,
          :email,
          :phone,
          :image
      )
    end
  end
  # -----------------------------------------------

end