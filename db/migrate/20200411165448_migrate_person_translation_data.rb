class MigratePersonTranslationData < ActiveRecord::Migration[5.2]
  def up

    if Person.last.respond_to?(:untranslated_designation)
      Person.where.not(untranslated_designation: nil).find_each do |person|
        Migration::Translation::PersonJob.set(wait_until: 30.minutes.from_now).perform_later(person.id)
      end
    end
  end

  def down
  end
end
