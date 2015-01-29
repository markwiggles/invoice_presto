module Account

  class FreightCodesController < ApplicationController

    # -----------------------------------------------
    # CREATE
    def new
      @freight_code = FreightCode.new
    end

    def create
      @freight_code = FreightCode.new(freight_code_params)

      if @freight_code.save
        respond_to do |format|
          format.html { redirect_to account_settings_path }
          format.js {render :js => 'refreshList();'}
        end
      end
    end

    # -----------------------------------------------
    # UPDATE
    def edit
      @freight_code = FreightCode.find params[:id]
    end

    def update
      @freight_code = FreightCode.find params[:id]

      if @freight_code.update_attributes freight_code_params
        respond_to do |format|
          format.html { redirect_to account_settings_path }
          format.js {render :js => 'refreshList();'}
        end
      end
    end

    # -----------------------------------------------
    # DELETE
    def delete
      @freight_code = FreightCode.find params[:id]
    end

    def destroy
      @freight_code = FreightCode.find(params[:id]).destroy
      respond_to do |format|
        format.html { redirect_to account_settings_path }
        format.js
      end

    end

    # -----------------------------------------------
    def freight_code_params

      params.require(:freight_code).permit(
          :name,
          :rate
      )
    end
  end
  # -----------------------------------------------

end