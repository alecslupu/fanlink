# frozen_string_literal: true
class Api::V1::PostsController < ApiController
  before_action :load_post, only: %i[update]
  before_action :admin_only, only: %i[list]
  skip_before_action :require_login, :set_product, only: %i[share]
  # **
  # @api {post} /posts Create a post.
  # @apiName CreatePost
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  # This creates a post and puts in on the feed of the author's followers. It also sends a push notification
  # to poster's followers if the notify_followers flag is set to true.
  #
  # @apiParam (body) {Object} post
  #   The post object container for the post parameters.
  #
  # @apiParam (body) {String} [post.body]
  #   The body of the message.
  #
  # @apiParam (body) {Attachment} [post.picture]
  #   Post picture, this should be `image/gif`, `image/png`, or `image/jpeg`.
  #
  # @apiParam (body) {Attachment} [post.audio]
  #   Post audio, this should be `audio/acc`.
  #
  # @apiParam (body) {Boolean} [post.global]
  #   Whether the post is global (seen by all users).
  #
  # @apiParam (body) {String} [post.starts_at]
  #   When the post should start being visible (same format as in responses).
  #
  # @apiParam (body) {String} [post.ends_at]
  #   When the post should stop being visible (same format as in responses).
  #
  # @apiParam (body) {Integer} [post.repost_interval]
  #   How often this post should be republished.
  #
  # @apiParam (body) {String} [post.status]
  #   Valid values: "pending", "published", "deleted", "rejected"
  #
  # @apiParam (body) {Integer} [post.priority]
  #   Priority value for post.
  #
  # @apiParam (body) {Boolean} [post.recommended] (Admin or product account)
  #   Whether the post is recommended.
  #
  # @apiParam (body) {Boolean} [post.global]
  #   Whether the post is global (seen by all users).
  #
  # @apiParam (body) {String} [post.starts_at]
  #   When the post should start being visible (same format as in responses).
  #
  # @apiParam (body) {String} [post.ends_at]
  #   When the post should stop being visible (same format as in responses).
  #
  # @apiParam (body) {Integer} [post.repost_interval]
  #   How often this post should be republished.
  #
  # @apiParam (body) {String} [post.status]
  #   Valid values: "pending", "published", "deleted", "rejected"
  #
  # @apiParam (body) {Integer} [post.priority]
  #   Priority value for post.
  #
  # @apiParam (body) {Boolean} [post.recommended] (Admin)
  #   Whether the post is recommended.
  #
  # @apiParam (body) {Boolean} [post.notify_followers]
  #   Whether a push notification should be sent to the posters followers.
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #     post: { ..post json..see get post action ....}
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "Body is required, blah blah blah" }
  # *

  # def create
  #   @post = Post.create(post_params.merge(person_id: current_user.id))
  #   if @post.valid?
  #     if post_params["status"].blank?
  #       @post.published!
  #     end
  #     @post.post if @post.published?
  #     broadcast(:post_created, current_user, @post, @api_version)
  #     return_the @post
  #   else
  #     render json: { errors: @post.errors.messages }, status: :unprocessable_entity
  #   end
  # end

  # **
  # @api {delete} /posts/:id Delete (hide) a single post.
  # @apiName DeletePost
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This deletes a single post by marking as deleted. Can only be called by the creator.
  #
  # @apiParam (path) {Integer} id The id of the post you want to delete
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 401 Unauthorized, etc.
  # *

  def destroy
    post = Post.visible.find(params[:id])
    if post.person == current_user
      post.deleted!
      post.delete_real_time
      head :ok
    else
      render_not_found
    end
  end

  # **
  # @api {get} /posts Get posts for a date range.
  # @apiName GetPosts
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  # This gets a list of posts for a from date, to date, with an optional
  # limit and person. Posts are returned newest first, and the limit is applied to that ordering.
  # Posts included are posts from the passed in person or, if none, the current
  # user along with those of the users the current user is following.
  #
  # @apiParam (body) {Integer} [person_id]
  # The person whose posts to get. If not supplied, posts from current user plus those from
  # people the current user is following will be returned.
  #
  # @apiParam (body) {String} from_date
  #   From date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.
  #
  # @apiParam (body) {String} to_date
  #   To date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.
  #
  # @apiParam (body) {Integer} [limit]
  #   Limit results to count of limit.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "posts": [
  #       { ....post json..see get post action ....
  #       },....
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 422 Unprocessable, etc.
  # *
  #
  # def index
  #   if !check_dates(true)
  #     render json: { errors: "Missing or invalid date(s)" }, status: :unprocessable_entity
  #   else
  #     l = params[:limit].to_i
  #     l = nil if l == 0
  #     if params[:person_id].present?
  #       pid = params[:person_id].to_i
  #       person = Person.find_by(id: pid)
  #       if person
  #         @posts = Post.visible.for_person(person).in_date_range(Date.parse(params[:from_date]), Date.parse(params[:to_date])).order(created_at: :desc).limit(l)
  #       else
  #         render_error("Cannot find that person.")
  #         return
  #       end
  #     else
  #       @posts = Post.visible.following_and_own(current_user).in_date_range(Date.parse(params[:from_date]), Date.parse(params[:to_date])).order(created_at: :desc).limit(l)
  #     end
  #     @post_reactions = current_user.post_reactions.where(post_id: @posts).index_by(&:post_id)
  #     return_the @posts
  #   end
  # end

  # **
  # @api {get} /posts/list Get a list of posts (ADMIN ONLY).
  # @apiName ListPosts
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a list of posts with optional filters and pagination.
  #
  # @apiParam (query) {Integer} [page]
  #   The page number to get. Default is 1.
  #
  # @apiParam (query) {Integer} [per_page]
  #   The pagination division. Default is 25.
  #
  # @apiParam (query) {Integer} [id_filter]
  #   Full match on post.id. Will return either a one element array or an empty array.
  #
  # @apiParam (query) {Integer} [person_id_filter]
  #   Full match on person id.
  #
  # @apiParam (query) {String} [person_filter]
  #   Full or partial match on person username or email.
  #
  # @apiParam (query) {String} [body_filter]
  #   Full or partial match on post body.
  #
  # @apiParam (query) {String} [posted_after_filter]
  #   Posted at or after timestamp. Format: "2018-01-08T12:13:42Z"
  #
  # @apiParam (query) {String} [posted_before_filter]
  #   Posted at or before timestamp. Format: "2018-01-08T12:13:42Z"
  #
  # @apiParam (query) {String} [status_filter]
  #   Post status. Valid values: pending published deleted rejected errored
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "posts": [
  #       {
  #         "id": "123",
  #         "person_id": 123,
  #         "body": "Do you like my body?",
  #         "picture_url": "http://example.com/pic.jpg",
  #         "global": false,
  #         "starts_at":  "2018-01-01T00:00:00Z",
  #         "ends_at":    "2018-01-31T23:59:59Z",
  #         "repost_interval": 0,
  #         "status": "published",
  #         "priority": 0,
  #         "recommended": false,
  #         "created_at": "2017-12-31T12:13:42Z",
  #         "updated_at": "2017-12-31T12:13:42Z"
  #       },...
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 401 Unauthorized
  # *
  #
  # def list
  #   @posts = paginate apply_filters
  #   @posts = @posts.for_tag(params[:tag]) if params[:tag]
  #   @posts = @posts.for_category(params[:category]) if params[:category]
  #   return_the @posts
  # end

  # **
  # @api {get} /posts/:id Get a single post.
  # @apiName GetPost
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a single post for a post id.
  #
  # @apiParam (path) {Integer} id The id of the post
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "post": {
  #       "id": "1234",
  #       "create_time":"2018-02-18T06:32:24Z",
  #       "body":"post body",
  #       "picture_url": "www.example.com/pic.jpg",
  #       "audio_url": "www.example.com/audio.aac",
  #       "audio_size": "the size of the file",
  #       "audio_content_type": "mime type of the content",
  #       "person": ....public person json...,
  #       "post_reaction_counts":{"1F389":1},
  #       "post_reaction":...see post reaction create json....(or null if current user has not reacted)
  #       "global": false,
  #       "starts_at":  "2018-01-01T00:00:00Z",
  #       "ends_at":    "2018-01-31T23:59:59Z",
  #       "repost_interval": 0,
  #       "status": "published",
  #       "post_reaction":...see post reaction create json....(or null if current user has not reacted),
  #       "recommended": false,
  #       "priority": 0,
  #     }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found
  # *
  #
  # def show
  #   @post = Post.for_product(ActsAsTenant.current_tenant).visible.find(params[:id])
  #   @post_reaction = @post.reactions.find_by(person: current_user)
  #   return_the @post
  # end

  # **
  # @api {get} /posts/:id/share Get a single, shareable post.
  # @apiName GetShareablePost
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a single post for a post id without authentication.
  #
  # @apiParam (path) {Integer} id The id of the post you want to share
  #
  # @apiParam (body) {String} product
  #   Product internal name.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "post": {
  #         "body": "Stupid thing to say",
  #         "picture_url": "http://host.name/path",
  #         "person": {
  #             "username": Tester McTestingson,
  #             "picture_url": "http://host.name/path"
  #          },
  #     }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found
  # *
  #
  # def share
  #   product = get_product
  #   if product.nil?
  #     render_error("Missing or invalid product.")
  #   else
  #     @post = Post.for_product(product).visible.find(params[:id])
  #     return_the @post
  #   end
  # end

  # **
  # @api {patch} /posts/:id Update a post
  # @apiName UpdatePost
  # @apiGroup Posts
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This updates a post.
  #
  # @apiParam (path) {Integer} id ID of the post being updated
  # @apiParam (body) {Object} post
  #   The post object container for the post parameters.
  #
  # @apiParam (body) {String} [post.body]
  #   The body of the post.
  #
  # @apiParam (body) {Attachment} [post.picture]
  #   Post picture, this should be `image/gif`, `image/png`, or `image/jpeg`.
  #
  # @apiParam (body) {Boolean} [post.global]
  #   Whether the post is global (seen by all users).
  #
  # @apiParam (body) {String} [post.starts_at]
  #   When the post should start being visible (same format as in responses).
  #
  # @apiParam (body) {String} [post.ends_at]
  #   When the post should stop being visible (same format as in responses).
  #
  # @apiParam (body) {Integer} [post.repost_interval]
  #   How often this post should be republished.
  #
  # @apiParam (body) {String} [post.status]
  #   Valid values: "pending", "published", "deleted", "rejected"
  #
  # @apiParam (body) {Integer} [post.priority]
  #   Priority value for post.
  #
  # @apiParam (body) {Boolean} [post.notify_followers]
  #   Whether a push notification should be sent to the posters followers.
  #
  # @apiParam (body) {Boolean} [post.recommended] (Admin)
  #   Whether the post is recommended.
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #     post: { ..post json..see list posts action ....}
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 401, 404
  # *
  #
  # def update
  #   @post.update(post_params)
  # end

private
  # def apply_filters
  #   posts = Post.for_product(ActsAsTenant.current_tenant).order(created_at: :desc)
  #   params.each do |p, v|
  #     if p.end_with?("_filter") && Post.respond_to?(p)
  #       posts = posts.send(p, v)
  #     end
  #   end
  #   posts
  # end

  def get_product
    product = nil
    if params[:product].present?
      product = Product.find_by(internal_name: params[:product])
    end
    product
  end

  def load_post
    @post = Post.cached_for_product(ActsAsTenant.current_tenant).find(params[:id])
  end

  def post_params
    params.require(:post).permit(%i[body audio picture global starts_at ends_at repost_interval status priority notify_followers category_id] +
                                     ((current_user.admin? || current_user.product_account? || current_user.super_admin?) ? [:recommended] : []))
  end
end
