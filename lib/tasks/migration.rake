namespace :migration do
  desc "Migrate all to to active Storage"
  task migrate_to_active_storage: :environment do
    Rake::Task["migration:migrate_badge_to_active_storage"].invoke
  end

  desc "Migrate badges to active Storage"
  task migrate_badge_to_active_storage: :environment do
    Badge.where.not(picture_file_name: nil).find_each do |badge|
      url = paperclip_asset_url(badge, :picture, badge.product)
      badge.picture.attach(io: open(url), filename: badge.picture_file_name, content_type: badge.picture_content_type)
    end
  end




  def paperclip_asset_url(object, field_name, product)
    base_url = "https://s3.#{Rails.application.secrets.aws_region}.amazonaws.com/#{Rails.application.secrets.aws_bucket}"
    image = object.send("#{field_name}_file_name")

    ext = File.extname(image)

    data = [
      object.class.name.pluralize.downcase,
      field_name.pluralize,
      object.id,
      "original",
      object.send("#{field_name}_updated_at").to_i
    ].join("/")
    hash = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.const_get("SHA1").new, Rails.application.secrets.paperclip_secret, data)

    id_partition = ("%09d".freeze % object.id).scan(/\d{3}/).join("/".freeze)

    url = [ base_url, product.internal_name,
            object.class.name.pluralize.downcase,
            field_name.pluralize, id_partition, "original", hash + ext].join("/")
    url += "?#{object.send("#{field_name}_updated_at").to_i}"

    url
  end
end
