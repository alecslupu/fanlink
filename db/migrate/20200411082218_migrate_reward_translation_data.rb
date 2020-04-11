class MigrateRewardTranslationData < ActiveRecord::Migration[5.2]
  def up
    langs = ["en", "es", "ro"]
    Reward.reset_column_information

    if Reward.last.respond_to?(:untranslated_name)
      Reward.where.not(untranslated_name: nil).find_each do |reward|

        langs.each do |value|
          next if reward.untranslated_name[value].nil?
          next if reward.untranslated_name[value].empty?
          next if reward.untranslated_name[value] == '-'

          I18n.locale = value
          reward.name = reward.untranslated_name[value]
          reward.save
        end
        unless Reward.with_translations('en').where(id: reward.id).first.present?
          next if reward.untranslated_name["un"].nil?
          next if reward.untranslated_name["un"].empty?
          I18n.locale = "en"
          reward.name = reward.untranslated_name["un"]
          reward.save
        end
      end
    end
  end
  def down

  end
end
