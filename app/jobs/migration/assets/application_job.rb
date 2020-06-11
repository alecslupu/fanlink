module Migration
  module Assets
    class ApplicationJob < ::ApplicationJob
      queue_as :migration

      protected

      def paperclip_asset_url(object, field_name, product)
        base_url = "https://s3.us-east-1.amazonaws.com/fanlink-prod"
        image = object.send("#{field_name}_file_name")

        ext = File.extname(image)

        data = [
          ActiveSupport::Inflector.underscore(object.class.name).pluralize,
          field_name.pluralize,
          object.id,
          "original",
          object.send("#{field_name}_updated_at").to_i
        ].join("/")
        hash = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.const_get("SHA1").new, Rails.application.secrets.paperclip_prod_secret, data)

        id_partition = ("%09d".freeze % object.id).scan(/\d{3}/).join("/".freeze)

        url = [ base_url, product.internal_name,
                ActiveSupport::Inflector.underscore(object.class.name).pluralize,
                field_name.pluralize, id_partition, "original", hash + ext].join("/")
        url += "?#{object.send("#{field_name}_updated_at").to_i}"

        url
      end
    end
  end
end
