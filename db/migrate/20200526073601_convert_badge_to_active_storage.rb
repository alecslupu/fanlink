class ConvertBadgeToActiveStorage < ActiveRecord::Migration[5.2]
  def up
    Badge.where.not(picture_file_name: nil).find_each do |badge|
      Migration::Assets::BadgeJob.perform_later(badge.id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

end
