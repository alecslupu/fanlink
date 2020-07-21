class MigrateAssetsToCourseware < ActiveRecord::Migration[6.0]
  def up
    classes = %w[ ImagePage DownloadFilePage VideoPage Certificate PersonCertificate ]

    classes.each do |klass|
      ActiveStorage::Attachment.where(record_type: klass).update_all(record_type: "Fanlink::Courseware::#{klass}")
    end
  end

  def down
    classes = %w[ ImagePage DownloadFilePage VideoPage Certificate PersonCertificate ]

    classes.each do |klass|
      ActiveStorage::Attachment.where(record_type: "Fanlink::Courseware::#{klass}").update_all(record_type: klass)
    end
  end
end
