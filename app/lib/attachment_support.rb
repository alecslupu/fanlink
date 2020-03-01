module AttachmentSupport
  extend ActiveSupport::Concern

  module ClassMethods
    def has_image_called(name)
      has_attached_file name,
        default_url: nil,
        styles: {
          optimal: "1000x",
          thumbnail: "100x100#",
        },
        convert_options: {
          optimal: "-quality 75 -strip",
        }

      validates_attachment name,
        content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
        size: { in: 0..5.megabytes }

      class_eval <<-EOE
        def #{name}_url
          #{name}.file? ? #{name}.url : nil
        end
        def #{name}_optimal_url
          #{name}.file? ? #{name}.url(:optimal) : nil
        end
        Paperclip.interpolates :product do |attachment, style|
          if attachment.instance.class.to_s == "Product"
            attachment.instance.internal_name
          else
            attachment.instance.product.internal_name
          end
        end
        EOE
    end

    def has_audio_called(name)
      has_attached_file name, default_url: nil
      validates_attachment name,
        content_type: { content_type: ["audio/mpeg", "audio/mp4", "audio/mpeg", "audio/x-mpeg", "audio/aac", "audio/x-aac", "video/mp4"] },
        size: { in: 0..10.megabytes }

      class_eval <<-EOE
        def #{name}_url
          #{name}.file? ? #{name}.url : nil
        end
        Paperclip.interpolates :product do |attachment, style|
          if attachment.instance.class.to_s == "Product"
            attachment.instance.internal_name
          else
              attachment.instance.product.internal_name
          end
        end
      EOE
    end

    def has_video_called(name)
      has_attached_file name, default_url: nil
      class_eval <<-EOE
        def #{name}_url
          #{name}.file? ? #{name}.url : nil
        end
        Paperclip.interpolates :product do |attachment, style|
          if attachment.instance.class.to_s == "Product"
            attachment.instance.internal_name
          else
              attachment.instance.product.internal_name
          end
        end
      EOE
    end

    def has_course_image_called(name)
      has_attached_file name,
                        default_url: nil,
                        styles: {
                          optimal: "1920x1080",
                          large: "3840x2160",
                          thumbnail: "100x100#",
                        },
                        convert_options: {
                          optimal: "-quality 90 -strip",
                        }
      validates_attachment name,
                           content_type: { content_type: ["image/jpeg", "image/gif", "image/png", "application/pdf"] },
                           size: { in: 0..5.megabytes }

      class_eval <<-EOE
        def #{name}_url
          #{name}.file? ? #{name}.url : nil
        end
        def #{name}_optimal_url
          #{name}.file? ? #{name}.url(:optimal) : nil
        end
        Paperclip.interpolates :product do |attachment, style|
          if attachment.instance.class.to_s == "Product"
            attachment.instance.internal_name
          else
            attachment.instance.product.internal_name
          end
        end
      EOE
    end

    def has_pdf_file_called(name)
      has_attached_file name,
                        default_url: nil,
                        convert_options: {
                          optimal: "-quality 90 -strip",
                        }
      validates_attachment name,
                           content_type: { content_type: ["application/pdf"] },
                           size: { in: 0..5.megabytes }

      class_eval <<-EOE
        def #{name}_url
          #{name}.file? ? #{name}.url : nil
        end
        Paperclip.interpolates :product do |attachment, style|
          if attachment.instance.class.to_s == "Product"
            attachment.instance.internal_name
          else
              attachment.instance.product.internal_name
          end
        end
      EOE
    end
  end
end
