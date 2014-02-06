class ItemsController < ApplicationController
  before_filter :authenticate!,  only: [:create, :destroy]
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
    render text: 'destroy'
  end

  private

  def authenticate!
    if Rails.configuration.gyazo_id && params[:id] != Rails.configuration.gyazo_id
      raise 'ID is incorrect'
    end
  end

  def set_item
    filename = "#{params[:name]}.#{params[:format].to_s}"
    @item = Item.find_by_image_file_name(filename)
  end
end
