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
    item = Item.create_with_imagedata(params[:imagedata])
    url = "#{request.protocol}#{request.host_with_port}/#{item.image_file_name}"
    render text: url
  end

  # DELETE /items/huge.img
  def destroy
    @item.destroy
    redirect_to root_url
  end

  private
    def set_item
      filename = "#{params[:name]}.#{params[:format].to_s}"
      @item = Item.find_by_image_file_name(filename)
    end
end
