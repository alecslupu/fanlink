json.id following.id.to_s
json.follower do
  json.cache! ["v4", following.follower] do
    json.partial! "api/v3/people/person", locals: { person: following.follower }
  end
end
json.followed do
  json.cache! ["v4", following.followed] do
    json.partial! "api/v3/people/person", locals: { person: following.followed }
  end
end
