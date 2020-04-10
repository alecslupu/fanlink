class MigratePostTranslationData < ActiveRecord::Migration[5.2]
  def up
    langs = TranslationThings::LANGS.keys - ["un"]
    if Post.respond_to?(:has_manual_translated)
      PaperTrail.enabled = false
      Post.includes(:person).where.not(untranslated_body: nil).find_each do |post|
        next unless post.person.present?

        langs.each do |value|
          next if post.untranslated_body_to_h[value].nil?
          next if post.untranslated_body_to_h[value] == '-'
          I18n.locale = value
          post.body = post.untranslated_body_to_h[value]
          post.save rescue nil
        end
        unless Post.with_translations('en').where(id: post.id).first.present?
          next if post.untranslated_body_to_h["un"].nil?
          next if post.untranslated_body_to_h["un"].empty?
          I18n.locale = "en"
          post.body = post.untranslated_body_to_h["un"]
          post.save rescue nil
        end
      end
      PaperTrail.enabled = true
    end
  end

  def down
  end
end
