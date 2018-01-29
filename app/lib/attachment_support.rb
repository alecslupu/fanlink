module AttachmentSupport
  extend ActiveSupport::Concern

  module ClassMethods
    def has_image_called(name)
      has_attached_file name
      validates_attachment name,
                          content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                          size: { in: 0..900.kilobytes }

      class_eval <<-EOE
        def #{name}_url
          #{name}.file? ? #{name}.url : nil
        end
      EOE
    end
  end
end
