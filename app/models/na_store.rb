class NaStore
  include Mongoid::Document

  attr_accessor :store_image_cache, :remote_store_image_url

  NA_HEADERS.each do |f|
    field f, type: String
  end

  field :store_image
  mount_uploader :store_image, StoreImageUploader
end
