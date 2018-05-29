module AttachmentSupport
  extend ActiveSupport::Concern

  module ClassMethods
    def has_image_called(name)
      has_attached_file name , :default_url => nil
      validates_attachment name,
                           content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                           styles: { thumbnail: "100x100#"},
                           size: { in: 0..10.megabytes }

      class_eval <<-EOE
        def #{name}_url
          #{name}.file? ? #{name}.url : nil
        end
        Paperclip.interpolates :product do |attachment, style|
          attachment.instance.product.internal_name
        end
      EOE
    end

    def has_audio_called(name)
      has_attached_file name , :default_url => nil
      validates_attachment name,
                          content_type: { content_type: ["audio/mpeg", "audio/mp4", "audio/aac", "audio/x-aac"] },
                          size: { in: 0..10.megabytes }

      class_eval <<-EOE
        def #{name}_url
          #{name}.file? ? #{name}.url : nil
        end
        Paperclip.interpolates :product do |attachment, style|
          attachment.instance.product.internal_name
        end
      EOE
    end
  end
end
