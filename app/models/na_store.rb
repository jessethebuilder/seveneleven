class NaStore
  include Mongoid::Document

  has_and_belongs_to_many :playlists

  attr_accessor :store_image_cache, :remote_store_image_url


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

  field :store_image
  mount_uploader :store_image, StoreImageUploader
end
