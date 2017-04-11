require "#{Rails.root}/lib/assets/s3_helper"
require 'open-uri'

class NaStore
  include Mongoid::Document
  include S3Helper

  has_and_belongs_to_many :playlists

  attr_accessor :fz_image_cache, :remote_fz_image_url

  validates :location, presence: true, uniqueness: true, numericality: {integer_only: true}
  index({ location: 1 }, { unique: true })

  def NaStore.bool_types
    [:nblc_highlight, :nblc_member, :alcohol_flag, :liquor_flag, :gas_flag]
  end

  def NaStore.int_types
    [:location]
  end

  NA_HEADERS.each do |f|
    if NaStore.int_types.include?(f)
      type = Integer
    elsif NaStore.bool_types.include?(f)
      type = Boolean
    else
      type = String
    end

    field f, type: type
  end

  field :fz_image
  field :fz_image_thumb

  # mount_uploader :fz_image, StoreImageUploader

  def self.all_headers
    a = NA_HEADERS
    a << :fz_image
    a << :fz_image_thumb
    a
  end

  def self.to_csv
    headers = all_headers
    CSV.generate do |csv|
      csv << headers
      NaStore.all.each do |s|
        a = headers.map{ |h| s.send(h) }
        csv << a
      end
    end
  end

  before_save :save_fz_image_to_s3

  # private

  def save_fz_image_to_s3
    img = self.fz_image
    img.original_filename =~ /\.(.+)$/
    ext = $1

    file_name = "fz_images/#{self.location}.#{ext}"
    if img && img =~ /^data:/
      self.fz_image = save_file_data_to_s3(img, file_name)
    elsif img.class == ActionDispatch::Http::UploadedFile
      self.fz_image = save_file_to_s3(img, file_name)
    end
    # 
    # thumb = MiniMagick::Image.open(self.fz_image)
    # thumb.resize('50x50')
    # self.fz_image_thumb = save_file_to_s3(IO.read(thumb.to_s), "fz_images/thumbs/#{self.location}.#{ext}")
  end


end
