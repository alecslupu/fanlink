class SetPersonBirthdate < ActiveRecord::Migration[5.1]
  def change
    Person.all.each do |person|
      person.birthdate = "2000-02-28"
      person.save
    end
  end
end
