class Api::V3::Docs::PostReactionsDoc < Api::V3::Docs::BaseDoc
  doc_tag name: "PostReactions", desc: "User reactions to a post"
  route_base "api/v3/post_reactions"

  components do
    resp PostReactionsArray: ["HTTP/1.1 200 Ok", :json, data: {
      post_reactions: [
        post_reaction: :PostReactionJson
      ]
    }]
    resp PostReactionsObject: ["HTTP/1.1 200 Ok", :json, data: {
      post_reaction: :PostReactionJson
    }]

    body! :PostReactionCreateForm, :form, data: {
      post_reaction!: {
        reaction!: { type: String, desc: "The identifier for the reaction. Accepts stringified hex values between 0 and 10FFFF, inclusive." }
      }
    }
    body! :PostReactionUpdateForm, :form, data: {
      post_reaction!: {
        reaction: { type: String, desc: "The identifier for the reaction. Accepts stringified hex values between 0 and 10FFFF, inclusive." }
      }
    }
  end

  # api :index, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  api :create, "React to a post." do
    need_auth :SessionCookie
    desc "This reacts to a post."
    path! :post_id, Integer, desc: "The id of the post to which you are reacting."
    body_ref :PostReactionCreateForm
    response_ref 200 => :PostReactionsObject
  end

  # api :list, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :show, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  api :update, "Update a reaction to a post." do
    need_auth :SessionCookie
    desc "This updates a reaction on a post."
    path! :post_id, Integer, desc: "The id of the post to which you are reacting."
    body_ref :PostReactionUpdateForm
    response_ref 200 => :PostReactionsObject
  end

  api :destroy, "Delete a reaction to a post." do
    need_auth :SessionCookie
    desc "This deletes a reaction to a post."
    path! :post_id, Integer, desc: "The id of the post to which you are reacting."
    response_ref 200 => :OK
  end
end
