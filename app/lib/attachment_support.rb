#
# A mixin for adding paper clip attachment support to models. See `has_image_called`
# and `has_blob_called` for details.
#
module AttachmentSupport
  extend ActiveSupport::Concern
  class FormatError < ::StandardError;end

  included do
    include attachment_support_module
  end

  module ClassMethods

    #
    # Add an attached image. The image data will be stored on S3, using paperclip.
    #
    # This will require just the standard paperclip migration attributes.
    #
    def has_image_called(name)

      instance_eval <<-EOE
        def #{name}_url
          #{name}.file? ? 
          super(id.to_s.presence)
        end

        validate               :#{name}_empty_error_cache
        validates_inclusion_of :#{name}_type,
                               :in        => %w[image/gif image/png image/jpeg],
                               :allow_nil => true,
                               :message   => lambda { |*| _('Invalid image format.') }

        before_save :#{name}_push_image_to_s3
        after_save  :#{name}_delete_old_s3
      EOE
      add_attachment_image_instance_methods_for(name)
    end

    private

    #
    # Stuffing all the generated instance methods into an anonymous Module
    # makes the string `module_eval` string wrangling cleaner. It also
    # means that we don't have to worry about the order of things that
    # much, we can add methods to the module *after* it has been mixed
    # (via the `included` ActiveSupport::Concern hook) and everything
    # just works.
    #
    def attachment_support_module
      @attachment_support_module ||= Module.new
    end

    def add_attachment_image_instance_methods_for(name)
      #
      # Something deep inside gettext gets all confused and upset if we use
      # heredocs in here so we use the somewhat non-tradional `%Q{ ... }`
      # strings instead. I don't understand it and I'm not drunk enough to
      # try to figure out WTF is really going on.
      #
      attachment_support_module.module_eval(%Q{
        def #{name}
          if(@#{name}_magick)
            @#{name}_magick.to_blob
          elsif(!self.#{name}_id)
            nil
          elsif(data = Flaws.s3_download(Flaws.path_to_image(self.#{name}_id)))
            data
          else
            complain("Invalid image \#{self.#{name}_id} in \#{self.class}-\#{self.id}, not on S3")
            nil
          end
        end

        def #{name}_image
          if(@#{name}_magick)
            @#{name}_magick
          else
            Magick::Image.from_blob(self.#{name})[0]
          end
        end

        def #{name}=(src)
          @#{name}_already_on_s3 = false
          if(src.nil?)
            @#{name}_old_id     = self.#{name}_id
            self.#{name}_id     = nil
            self.#{name}_width  = nil
            self.#{name}_height = nil
            self.#{name}_type   = nil
            return
          elsif(src.is_a?(String))
            @#{name}_magick = Magick::Image.from_blob(throw_a_hissy_fit_if_bad_format(src))[0]
          elsif(src.is_a?(Magick::Image))
            @#{name}_magick = src
          elsif(src.is_a?(TempImage))
            self.#{name}_id     = src.picture_id
            self.#{name}_width  = src.picture_width
            self.#{name}_height = src.picture_height
            self.#{name}_type   = src.picture_type
            src.release_picture
            @#{name}_already_on_s3 = true
            return
          elsif(src.respond_to?(:read))
            @#{name}_magick = Magick::Image.from_blob(throw_a_hissy_fit_if_bad_format(src.read))[0]
          else
            raise ArgumentError.new("#{name}= needs a nil, String, Magick::Image, or something that understands `read`")
          end
          @#{name}_magick.auto_orient!
          @#{name}_magick.colorspace = Magick::SRGBColorspace if(!COLOR_SPACES.include?(@#{name}_magick.colorspace))
          self.#{name}_width  = @#{name}_magick.columns
          self.#{name}_height = @#{name}_magick.rows
          self.#{name}_type   = @#{name}_magick.mime_type # MagicalIdiot isn't smart enough for this.
        rescue Magick::ImageMagickError, AttachmentSupport::FormatError
          (@#{name}_error_cache ||= [ ]).push([:#{name}, _('Invalid image format.')])
        end

      private

        def #{name}_push_image_to_s3
          return if(!@#{name}_magick || @#{name}_already_on_s3)

          self.#{name}_id = UUIDTools::UUID.random_create.to_s
          obj = Flaws.s3_upload(
            :data => @#{name}_magick.to_blob,
            :to   => Flaws.path_to_image(self.#{name}_id),
            :as   => self.#{name}_type
          )
          raise "Could not push \#{self.#{name}_id} image to S3" if(!obj)

          @#{name}_already_on_s3 = true
          @#{name}_magick        = nil

          true
        end

        def #{name}_delete_old_s3
          Flaws.s3_rm(Flaws.path_to_image(@#{name}_old_id)) if(@#{name}_old_id)
        end

        def #{name}_empty_error_cache
          @#{name}_error_cache.to_a.each { |field, msg| self.errors.add(field, msg) }
        end

        #
        # ImageMagick is/was/will-be full of format handling holes so we have
        # to do it ourselves.
        #
        def throw_a_hissy_fit_if_bad_format(data)
          return data if(MagicalIdiot.what_is_the_mime_type_of(data).in?(%w[image/jpeg image/png image/gif]))
          raise AttachmentSupport::FormatError
        end

        def complain(msg)
          if(Rails.env.development?)
            raise msg
          else
            Rails.logger.error msg
          end
        end
      })
    end
  end

end
