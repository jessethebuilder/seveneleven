module S3Helper
  def save_file_data_to_s3(file_data, file_name)
    file = URI::Data.new(file_data)
    # Get file extention and type
    c = file.content_type.split('/')
    type = c[0]

    # Move data to S3, and save URL of created resource
    ext = c[1]

    # Build a file path for s3
    # file_name = "na_store_fz_image_#{location}"
    path = "#{file_name}.#{ext}"

    # S3_BUCKET is set up in aws initializer
    saved_img = S3_BUCKET.object(path)
    # Save to S3
    saved_img.put(body: file.data, acl:'public-read')

    # Assign the S3 Url for the image to the image attribute
    return "#{S3_BUCKET.url}/#{path}"
  end
end
