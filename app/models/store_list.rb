class StoreList
  include Mongoid::Document

  belongs_to :user, inverse_of: :store_list

  # , inverse_of: :store_list
  # belongs_to :user, inverse_of: :current_store_list

  has_and_belongs_to_many :na_stores
  has_and_belongs_to_many :intl_stores

  field :name, type: String
  field :published, type: Boolean, default: false

  validate :name_if_published

  private

  def name_if_published
    if self.name.blank? && self.published?
      self.errors.add(:name, "cannot be blank")
    end
  end

  def StoreList.published
    where(:published => true)
  end

  def StoreList.unpublished
    where(published: false)
  end
end
