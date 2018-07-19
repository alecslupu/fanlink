class Api::V2::Docs::PostsDoc < Api::V2::Docs::BaseDoc
  doc_tag name: 'Posts', desc: "User/product posts"
  route_base 'api/v2/posts'

  components do
    resp :PostsArray => ['HTTP/1.1 200 Ok', :json, data:{
      :posts => [
        :post => :PostJson
      ]
    }]
    resp :PostsListsArray => ['HTTP/1.1 200 Ok', :json, data:{
      :posts => [
        :post => :PostListJson
      ]
    }]
    resp :PostsObject => ['HTTP/1.1 200 Ok', :json, data:{
      :post => :PostJson
    }]
    resp :PostsShareObject => ['HTTP/1.1 200 Ok', :json, data:{
      :post => :PostShareJson
    }]

    body! :PostCreateForm, :form, data: {
      :post! => {
        :body => { type: String, desc: 'The body of the message.' },
        :picture => { type: File, desc: 'Post picture, this should be `image/gif`, `image/png`, or `image/jpeg`.' },
        :audio => { type: File, desc: 'Post audio, this should be `audio/acc`.' },
        :global => { type: Boolean, desc: 'Whether the post is global (seen by all users).' },
        :starts_at => { type: String, format: 'date-time' , desc: 'When the post should start being visible (same format as in responses).' },
        :ends_at => { type: String, format: 'date-time' , desc: ' When the post should stop being visible (same format as in responses).' },
        :repost_interval => { type: Integer, desc: 'How often this post should be republished.'},
        :status => { type: String, desc: 'Valid values: "pending", "published", "deleted", "rejected"' },
        :priority => { type: Integer, desc: 'Priority value for post.' },
        :recommended => { type: Boolean, desc: 'Whether the post is recommended.(Admin or product account)'}
      }
    }

    body! :PostUpdateForm, :form, data: {
      :post! => {
        :body => { type: String, desc: 'The body of the message.' },
        :picture => { type: File, desc: 'Post picture, this should be `image/gif`, `image/png`, or `image/jpeg`.' },
        :audio => { type: File, desc: 'Post audio, this should be `audio/acc`.' },
        :global => { type: Boolean, desc: 'Whether the post is global (seen by all users).' },
        :starts_at => { type: String, format: 'date-time' , desc: 'When the post should start being visible (same format as in responses).' },
        :ends_at => { type: String, format: 'date-time' , desc: ' When the post should stop being visible (same format as in responses).' },
        :repost_interval => { type: Integer, desc: 'How often this post should be republished.'},
        :status => { type: String, desc: 'Valid values: "pending", "published", "deleted", "rejected"' },
        :priority => { type: Integer, desc: 'Priority value for post.' },
        :recommended => { type: Boolean, desc: 'Whether the post is recommended.(Admin or product account)'}
      }
    }
  end

  api :index, 'Get posts for a date range.' do
    need_auth :SessionCookie
    desc '  This gets a list of posts for a from date, to date, with an optional limit and person. Posts are returned newest first, and the limit is applied to that ordering.
    Posts included are posts from the passed in person or, if none, the current
    user along with those of the users the current user is following.'
    query :person_id, Integer, desc: 'The person whose posts to get. If not supplied, posts from current user plus those from people the current user is following will be returned.'
    query :tag, String, desc: 'Returns posts with the tag specified from the user and the user\'s that they are following'
    query :category, String, desc: 'Returns posts with the category specified from the user and the user\'s that they are following'
    response_ref 200 => :PostsArray
  end

  api :create, 'Create a post.' do
    need_auth :SessionCookie
    desc 'This creates a post and puts in on the feed of the author\'s followers. It also sends a push notification to poster\'s followers if the notify_followers flag is set to true.'
    body_ref :PostCreateForm
    response_ref 200 => :PostsObject
  end

  api :list, 'Get a list of posts (ADMIN ONLY).' do
    need_auth :SessionCookie
    desc 'This gets a list of posts with optional filters and pagination.'
    query :id_filter, Integer, desc: 'Full match on post.id. Will return either a one element array or an empty array.'
    query :person_id_filter, Integer, desc: 'Full match on person id.'
    query :person_filter, String, desc: 'Full or partial match on person username or email.'
    query :body_filter, String, desc: 'Full or partial match on post body.'
    query :posted_after_filter, String, desc: 'Posted at or after timestamp. Format: "2018-01-08T12:13:42Z"'
    query :posted_before_filter, String, desc: 'Posted at or before timestamp. Format: "2018-01-08T12:13:42Z"'
    query :status_filter, String, desc: 'Post status. Valid values: pending published deleted rejected errored'
    response_ref 200 => :PostsListsArray
  end

  api :show, 'Get a single post.' do
    need_auth :SessionCookie
    desc 'This gets a single post for a post id.'
    response_ref 200 => :PostsObject
  end

  api :share, 'Get a single, shareable post.', skip: [:SessionCookie] do
    desc 'This gets a single post for a post id.'
    path! :id, Integer, desc: 'The ID of the post you want to share.'
    response_ref 200 => :PostsShareObject
  end

  api :update, 'Update a post' do
    need_auth :SessionCookie
    desc 'This updates a post.'
    body_ref :PostUpdateForm
    response_ref 200 => :PostsObject
  end

  api :destroy, 'Delete (hide) a single post.' do
    need_auth :SessionCookie
    desc 'This deletes a single post by marking as deleted. Can only be called by the creator.'
    response_ref 200 => :OK
  end

end
