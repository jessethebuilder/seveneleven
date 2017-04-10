class NaStore
  include Mongoid::Document

  has_and_belongs_to_many :playlists

  attr_accessor :fz_image_cache, :remote_fz_image_url

  validates :location, presence: true, uniqueness: true
  index({ location: 1 }, { unique: true })

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

  field :fz_image
  # mount_uploader :fz_image, StoreImageUploader

  def self.all_headers
    a = NA_HEADERS
    # a << :fz_image
    a
  end

  def self.to_csv
    headers = all_headers
    CSV.generate do |csv|
      csv << headers
      NaStore.all.each do |s|
        a = headers.map{ |h| s.send(h) }
        csv << a
      end
    end
  end

  before_save :save_fz_image_to_s3

  # private

  def save_fz_image_to_s3
    if fz_image && fz_image =~ /^data:/
      # if image is a data url
      self.fz_image = save_file_to_s3(self.fz_image, "fz_image_#{location}")
    end
  end



  def save_file_to_s3(file_data, file_name)
    puts file_data
    img = URI::Data.new(file_data)

    # Get file extention and type
    c = img.content_type.split('/')
    type = c[0]

    # Move data to S3, and save URL of created resource
    ext = c[1]

    # Build a file path for s3
    # file_name = "na_store_fz_image_#{location}"
    path = "#{file_name}.#{ext}"

    # S3_BUCKET is set up in aws initializer
    saved_img = S3_BUCKET.object(path)
    # Save to S3
    saved_img.put(body: img.data, acl:'public-read')

    # Assign the S3 Url for the image to the image attribute
    return "#{S3_BUCKET.url}/#{path}"
  end
end
