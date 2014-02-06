class Item < ActiveRecord::Base
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def self.create_with_imagedata data
    if data.original_filename == 'gyazo.com'
      name = Time.now.to_i.to_s + '.png'
    else
      name = data.original_filename
    end
    item = new
    item.image = data.tempfile
    item.image_file_name = name
    item.save
    item
  end
end
