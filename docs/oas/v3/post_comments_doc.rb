class Api::V3::PostCommentsDoc < Api::V3::BaseDoc
  doc_tag name: "PostComments", desc: "Comments on a post"
  route_base "api/v3/post_comments"

  components do
    resp PostCommentsArray: ["HTTP/1.1 200 Ok", :json, data: {
      post_comments: [
        post_comment: :PostCommentJson
      ]
    }]
    resp PostCommentsListArray: ["HTTP/1.1 200 Ok", :json, data: {
      post_comments: [
        post_comment: :PostCommentListJson
      ]
    }]
    resp PostCommentsObject: ["HTTP/1.1 200 Ok", :json, data: {
      post_comment: :PostCommentJson
    }]

    body! :PostCommentCreateForm, :form, data: {
      post_comment!: {
        body!: { type: String, desc: "The body of the comment." },
      },
      mentions: [
        person_id!: { type: Integer, desc: "The id of the person mentioned." },
        location!: { type: Integer, desc: "Where the mention text starts in the comment." },
        length!: { type: Integer, desc: "The length of the mention text." }
      ]
    }
  end

  api :index, "Get the comments on a post." do
    need_auth :SessionCookie
    desc "This gets all the non-hidden comments on a post with pagination."
    path! :post_id, Integer, desc: "Post ID"
    response_ref 200 => :PostCommentsArray
  end

  api :create, "Create a comment on a post." do
    need_auth :SessionCookie
    desc "This creates a post comment. It is automatically attributed to the logged in user."
    path! :post_id, Integer, desc: "Post ID"
    body_ref :PostCommentCreateForm
    response_ref 200 => :PostCommentsObject
  end

  api :list, "Get a list of post comments (ADMIN)." do
    need_auth :SessionCookie
    desc "This gets a list of post comments with optional filters and pagination."
    query :body_filter, String, desc: "Full or partial match on comment body."
    query :person_filter, String, desc: "Full or partial match on person username or email."
    response_ref 200 => :PostCommentsListArray
  end

  # api :show, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :update, '' do
  #   desc ''
  #   form! data: {
  #     :! => {

  #     }
  #   }
  #   response_ref 200 => :
  # end

  api :destroy, "Delete a comment on a post." do
    need_auth :SessionCookie
    desc "This deletes a comment on a post. Can be performed by admin or creator of comment."
    path! :post_id, Integer, desc: "The id of the post to which the comment relates"
    response_ref 200 => :OK
  end
end
