class IntlStore
  include Mongoid::Document

  has_and_belongs_to_many :playlists

  int_types = [:founded, :stores]
  INTL_HEADERS.each do |f|
    type = int_types.include?(f) ? Integer : String
    field f, type: type
  end

  field :fz_image
  mount_uploader :fz_image, StoreImageUploader

  def self.all_headers
    a = INTL_HEADERS
    a << :fz_image
    a
  end

  def self.to_csv
    headers = all_headers
    CSV.generate do |csv|
      csv << headers
      IntlStore.all.each do |s|
        a = headers.map{ |h| s.send(h) }
        csv << a
      end
    end
  end
end
