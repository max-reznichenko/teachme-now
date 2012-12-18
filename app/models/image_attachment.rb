require "open-uri"

class ImageAttachment < ActiveRecord::Base
  attr_accessible :association_id, :association_type, :image
  validates :association_type, inclusion: %w(User)
  validates_attachment_content_type :image, :content_type => /image/

  belongs_to :association, polymorphic: true
  has_attached_file :image, styles: { :medium => "140x157#", :thumb => "100x100#" }


  def self.image_from_url(url, basename)
    extname = File.extname(url)
    image_file = Tempfile.new([basename, extname])
    image_file.binmode
    image_file.write open(URI::escape(url)).read
    image_file.rewind
    image_file
  end
end
