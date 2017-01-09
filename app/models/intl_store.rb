class IntlStore
  include Mongoid::Document

  INTL_HEADERS.each do |f|
    field f, type: String
  end
end
