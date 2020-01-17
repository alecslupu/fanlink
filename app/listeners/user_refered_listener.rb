class UserReferedListener
  def self.person_created(person_id, params)
    person = Person.find(person_id)

  end
end
