class NaStore
  include Mongoid::Document

  has_and_belongs_to_many :store_lists

  attr_accessor :store_image_cache, :remote_store_image_url

  NA_HEADERS.each do |f|
    field f, type: String
  end

  field :store_image
  mount_uploader :store_image, StoreImageUploader
end
