class ItemsController < ApplicationController
  before_filter :authenticate!,  only: [:create, :destroy]
  before_action :set_item, only: [:show, :destroy]

  # GET /
  def index
    @items = Item.all.page params[:page]
  end

  # GET /huge.img
  def show
    url = @item.image.url
    if url.include?('http')
      # production s3
      data = open(url)
      send_data data.read, type: @item.image_content_type, disposition: 'inline'
    else
      # development,test local
      path = Rails.root.join('public/' + url)
      send_file path, type: @item.image_content_type, disposition: 'inline'
    end
  end

  # POST /items
  def create
    item = Item.create_with_imagedata(params[:imagedata])
    render text: "#{request.protocol}#{request.host_with_port}/#{item.image_file_name}"
  end

  # DELETE /huge.img
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
    raise 'not item' if @item.nil?
  end
end
