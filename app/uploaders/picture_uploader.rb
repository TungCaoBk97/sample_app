class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [Settings.micropost.resize.horizon,
    Settings.micropost.resize.vertical]

  Rails.env.production? ? storage(:fog) : storage(:file)

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
