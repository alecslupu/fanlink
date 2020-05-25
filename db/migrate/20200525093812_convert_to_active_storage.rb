class ConvertToActiveStorage < ActiveRecord::Migration[5.2]
  require 'open-uri'

  def up
    # postgres
    get_blob_id = 'LASTVAL()'
    # mariadb
    # get_blob_id = 'LAST_INSERT_ID()'
    # sqlite
    # get_blob_id = 'LAST_INSERT_ROWID()'

    active_storage_blob_statement = ActiveRecord::Base.connection.raw_connection.prepare('active_storage_blob_statement', "
      INSERT INTO active_storage_blobs (
        key, filename, content_type, metadata, byte_size, checksum, created_at
      ) VALUES ($1, $2, $3, '{}', $4, $5, $6)")

    active_storage_attachment_statement = ActiveRecord::Base.connection.raw_connection.prepare('active_storage_attachment_statement',"
      INSERT INTO active_storage_attachments (
        name, record_type, record_id, blob_id, created_at
      ) VALUES ($1, $2, $3, #{get_blob_id}, $4)")

    Rails.application.eager_load!
    models = ActiveRecord::Base.descendants.reject(&:abstract_class?)

    transaction do
      Badge.find_each do |instance|

      end
      # modified:   app/models/badge.rb
      # modified:   app/models/certificate.rb
      # modified:   app/models/download_file_page.rb
      # modified:   app/models/image_page.rb
      # modified:   app/models/level.rb
      # modified:   app/models/merchandise.rb
      # modified:   app/models/message.rb
      # modified:   app/models/person.rb
      # modified:   app/models/person_certificate.rb
      # modified:   app/models/post.rb
      # modified:   app/models/product.rb
      # modified:   app/models/quest.rb
      # modified:   app/models/quest_activity.rb
      # modified:   app/models/room.rb
      # modified:   app/models/trivia/game.rb
      # modified:   app/models/trivia/picture_available_answer.rb
      # modified:   app/models/trivia/prize.rb
      # modified:   app/models/video_page.rb

      # models.each do |model|
      #   attachments = model.column_names.map do |c|
      #     if c =~ /(.+)_file_name$/
      #       $1
      #     end
      #   end.compact
      #
      #   if attachments.blank?
      #     next
      #   end
      #
      #   model.find_each.each do |instance|
      #     attachments.each do |attachment|
      #       if instance.send(attachment).path.blank?
      #         next
      #       end
      #
      #       ActiveRecord::Base.connection.execute_prepared(
      #         'active_storage_blob_statement', [
      #         key(instance, attachment),
      #         instance.send("#{attachment}_file_name"),
      #         instance.send("#{attachment}_content_type"),
      #         instance.send("#{attachment}_file_size"),
      #         checksum(instance.send(attachment)),
      #         instance.updated_at.iso8601
      #       ])
      #
      #       ActiveRecord::Base.connection.execute_prepared(
      #         'active_storage_attachment_statement', [
      #         attachment,
      #         model.name,
      #         instance.id,
      #         instance.updated_at.iso8601,
      #       ])
      #     end
      #   end
      # end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

  private

  def key(instance, attachment)
    SecureRandom.uuid
    # Alternatively:
    # instance.send("#{attachment}_file_name")
  end

  def checksum(attachment)
    # local files stored on disk:
    url = attachment.path
    Digest::MD5.base64digest(File.read(url))

    # remote files stored on another person's computer:
    # url = attachment.url
    # Digest::MD5.base64digest(Net::HTTP.get(URI(url)))
  end
end
