module Account

  class DebtorsController < ApplicationController

    # -----------------------------------------------
    # CREATE
    def new
      @debtor = Debtor.new
    end

    def create
      @debtor = Debtor.new(debtor_params)

      if @debtor.save
        respond_to do |format|
          format.html {redirect_to account_settings_path}
          format.js {render :js => 'refreshList();'}
        end
      end
    end
    # -----------------------------------------------
    # UPDATE
    def edit
      @debtor = Debtor.find params[:id]
    end

    def update
      @debtor = Debtor.find params[:id]
      if @debtor.update_attributes debtor_params
        respond_to do |format|
          format.html {redirect_to account_settings_path}
          format.js {render :js => 'refreshList();'}
        end
      end
    end
    # -----------------------------------------------
    # DELETE
    def delete
      @debtor = Debtor.find params[:id]

    end

    def destroy
      @debtor = Debtor.find(params[:id]).destroy
      respond_to do |format|
        format.html { redirect_to account_settings_path }
        format.js
      end
    end

    # -----------------------------------------------
    def debtor_params

      params.require(:debtor).permit(
          :name,
          :address1,
          :address2,
          :town,
          :postcode,
          :email,
          :phone,
      )
    end
  end
  # -----------------------------------------------

end
