class StoreList
  include Mongoid::Document

  belongs_to :user

  has_and_belongs_to_many :na_stores
  has_and_belongs_to_many :intl_stores

  field :name, type: String
  field :published, type: Boolean
end
