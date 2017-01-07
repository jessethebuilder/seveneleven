class IntlStore
  include Mongoid::Document

  INTL_HEADERS.each do |f|
    field f, type: String
  end

  field :lat, type: Float
  field :long, type: Float

  before_save :split_lat_long

  private

  def split_lat_long
    l = self.lat_long.split(/, ?/)
    self.lat = l[0]
    self.long = l[1]
    # self.save
  end
end
