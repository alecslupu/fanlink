module JsonHelpers
  def json
    @json ||= JSON.parse(response.body)
  end

  def person_private_json(person)
    person_profile_json(person).merge(
      "email" => person.email
    )
  end

  def person_profile_json(person)
    {
      "id"          => person.id,
      "username"    => person.username,
      "name"        => person.name,
      "picture_url" => person.picture_url
    }
  end
end
