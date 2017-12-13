class Api::V1::PeopleController < ApiController
  prepend_before_action :logout, only: :create

  skip_before_action :require_login, only: %i[ create ]

  #**
  # @api {post} /people Create person.
  # @apiName CreatePerson
  # @apiGroup People
  #
  # @apiDescription
  #   This is used to create a new person.
  #
  #   We will log them in along the way.
  #
  # @apiParam {Object} person
  #   The person's information.
  # @apiParam {String} person.email
  #   Email address.
  # @apiParam {String} [person.name]
  #   Name.
  # @apiParam {String} person.username
  #   Username. This needs to be unique.
  # @apiParam {String} person.password
  #   Password.
  # @apiParam {Attachment } [person.picture]
  #   Profile picture, this should be `image/gif`, `image/png`, or
  #   `image/jpeg`. You should specify at most one of `picture` and
  #   `picture_id`.
  # @apiParam {ObjectId} [person.picture_id]
  #   The profile picture as a temporary image. You should specify at
  #   most one of `picture` and `picture_id`.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "person": { // The full private version of the person.
  #       "id": "5016",
  #       "email": "addr@example.com",
  #       "username": "Pancakes.McGee",
  #       "name": "Pancakes McGee",
  #       "picture_url": "http://host.name/path",
  #     }
  #*
  def create
    @person = Person.create(person_params)
    if @person.valid?
      auto_login(@person)
    end
    return_the @person
  end

  def person_params
    person = params.require(:person).permit(:email, :name, :username, :password, :picture, :picture_id)
    if picture = person.delete(:picture).presence
      person[:picture] = picture.respond_to?(:read) ? picture.read : picture
    end
    if picture_id = person.delete(:picture_id).presence
      person[:picture] = TempImage.find(picture_id)
    end
    person
  end
end
