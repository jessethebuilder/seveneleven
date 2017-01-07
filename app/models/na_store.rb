class NaStore
  include Mongoid::Document

  NA_HEADERS.each do |f|
    field f, type: String
  end
end
