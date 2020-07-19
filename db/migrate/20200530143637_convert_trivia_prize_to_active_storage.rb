class ConvertTriviaPrizeToActiveStorage < ActiveRecord::Migration[6.0]
  def up
    Trivia::Prize.where.not(photo_file_name: nil).find_each do |prize|
      Migration::Assets::Trivia::PrizeJob.perform_later(prize.id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
