class MigrateMerchandiseTranslationData < ActiveRecord::Migration[5.2]
  def up

    Merchandise.reset_column_information

    if Merchandise.last.respond_to?(:untranslated_name)
      Merchandise::Translation.destroy_all
      Merchandise.where.not(untranslated_name: nil).find_each do |merchandise|
        Migration::Translation::MerchandiseJob.set(wait_until: 30.minutes.from_now).perform_later(merchandise.id)
      end
    end
  end
  def down
  end
end
