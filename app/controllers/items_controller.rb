class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]

  # GET /items
  def index
    @items = Item.all
  end

  # GET /items/huge.img
  def show
    data = open(@item.image.url)
    send_data data.read, type: @item.image_content_type, disposition: 'inline'
  end

  # POST /items
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/huge.img
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  private
    def set_item
      filename = "#{params[:name]}.#{params[:format].to_s}"
      @item = Item.find_by_image_file_name(filename)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:image)
    end
end
