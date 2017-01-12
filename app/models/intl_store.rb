class IntlStore
  include Mongoid::Document

  has_and_belongs_to_many :store_lists

  int_types = [:founded, :stores]
  INTL_HEADERS.each do |f|
    type = int_types.include?(f) ? Integer : String
    field f, type: type
  end

  field :store_image
  mount_uploader :store_image, StoreImageUploader
end
