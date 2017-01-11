class IntlStore
  include Mongoid::Document

  has_and_belongs_to_many :store_lists

  INTL_HEADERS.each do |f|
    field f, type: String
  end

  field :store_image
  mount_uploader :store_image, StoreImageUploader
end
