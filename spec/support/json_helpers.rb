module JsonHelpers
  def json
    @json ||= JSON.parse(response.body)
  end

  def message_json(msg)
    {
      "id"        => msg.id.to_s,
      "body"      => msg.body,
      "picture_url" => msg.picture_id,
      "person" => person_profile_json(msg.person)
    }
  end

  def person_private_json(person)
    person_profile_json(person).merge(
      "email" => person.email
    )
  end

  def person_profile_json(person)
    {
      "id"          => person.id.to_s,
      "username"    => person.username,
      "name"        => person.name,
      "picture_url" => person.picture_url
    }
  end
end
