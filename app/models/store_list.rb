class StoreList
  include Mongoid::Document

  belongs_to :user, inverse_of: :user

  has_and_belongs_to_many :na_stores
  has_and_belongs_to_many :intl_stores

  field :name, type: String
  field :published, type: Boolean

  validate :name_if_published

  private

  def name_if_published
    if self.name.blank? && self.published?
      self.errors.add(:name, "cannot be blank")
    end
  end
end
