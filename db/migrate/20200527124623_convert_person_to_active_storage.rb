class ConvertPersonToActiveStorage < ActiveRecord::Migration[5.2]
  def up
    Person.where.not(picture_file_name: nil).find_each do |person|
      Migration::Assets::PersonJob.perform_later(person.id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
