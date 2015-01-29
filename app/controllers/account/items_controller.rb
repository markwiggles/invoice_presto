module Account

  class ItemsController < ApplicationController

    # -----------------------------------------------
    # CREATE
    def new
      @item = Item.new
    end

    def create
      @item = Item.new(item_params)

      if @item.save
        respond_to do |format|
          format.html {redirect_to account_settings_path}
          format.js {render :js => 'refreshList();'}
        end
      end
    end
    # -----------------------------------------------
    # UPDATE
    def edit
      @item = Item.find params[:id]
    end

    def update
      @item = Item.find params[:id]
      if @item.update_attributes item_params
        respond_to do |format|
          format.html {redirect_to account_settings_path}
          format.js {render :js => 'refreshList();'}
        end
      end
    end
    # -----------------------------------------------
    # DELETE
    def delete
      @item = Item.find params[:id]
    end

    def destroy
      @item = Item.find(params[:id]).destroy
      respond_to do |format|
        format.html { redirect_to account_settings_path }
        format.js
      end
    end

    # -----------------------------------------------
    def item_params

      params.require(:item).permit(
          :name,
          :description,
          :price
      )
    end
  end
  # -----------------------------------------------

end