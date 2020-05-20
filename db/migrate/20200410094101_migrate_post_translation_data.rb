class MigratePostTranslationData < ActiveRecord::Migration[5.2]
  def up
    langs = TranslationThings::LANGS.keys - ["un"]
    if Post.respond_to?(:has_manual_translated)
      Post.where.not(untranslated_body: nil).find_each do |post|
        langs.each do |value|
          next if post.untranslated_body_to_h[value].nil?
          next if post.untranslated_body_to_h[value] == '-'
          I18n.locale = value
          post.body = post.untranslated_body_to_h[value]
          post.save
        end
        unless Post.with_translations('en').where(id: post.id).first.present?
          I18n.locale = "en"
          post.body = post.untranslated_body_to_h["en"]
          post.save
        end
      end
    end
  end

  def down
  end
end
