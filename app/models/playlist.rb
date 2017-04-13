class Playlist
  include Mongoid::Document

  belongs_to :user, inverse_of: :playlist

  has_and_belongs_to_many :na_stores
  has_and_belongs_to_many :intl_stores

  field :live, type: Boolean, default: false

  field :name, type: String
  field :published, type: Boolean, default: false

  field :user_to_return_to_on_publish, type: Integer

  validate :name_if_published

  def push_as_live
    puts 'Not yet implemented'
  end

  scope :live, -> { where(:live => true ) }

  private

  def name_if_published
    if self.name.blank? && self.published?
      self.errors.add(:name, "cannot be blank")
    end
  end

  def Playlist.published
    where(:published => true)
  end

  def Playlist.unpublished
    where(published: false)
  end
end
