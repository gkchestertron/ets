# encoding: utf-8

require 'carrierwave/storage/ftp'
# CarrierWave.configure do |config|
#   config.ftp_host = "s288250878.onlinehome.us"
#   config.ftp_port = 22
#   config.ftp_user = "u53652338-collab"
#   config.ftp_passwd = "@1Sauced"
#   config.ftp_folder = "/public_html/uploads"
#   config.ftp_url = "http://uploads.collaborave.com/public_html/uploads"
#   config.ftp_passive = true # false by default
# end
CarrierWave.configure do |config|
  config.ftp_host = "s288250878.onlinehome.us"
  config.ftp_port = 21
  config.ftp_user = "u53652338-ets"
  config.ftp_passwd = "@1Sauc3d"
  config.ftp_folder = "/images"
  config.ftp_url = "http://uploads.elitetimingsolutions.com/images"
  config.ftp_passive = true # false by default
end


class CoverPhotoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :ftp
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
