class Item < ActiveRecord::Base
  has_attached_file :image, styles: {thumb: '300x300#'}
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  default_scope :order => 'id DESC'

  def self.create_with_imagedata data
    if data.original_filename == 'gyazo.com'
      name = Time.now.to_i.to_s + '.png'
    else
      extname = File.extname(data.original_filename)
      name = Time.now.to_i.to_s + extname
    end
    item = new
    item.image = data.tempfile
    item.image_file_name = name
    item.save
    item
  end
end
