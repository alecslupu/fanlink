class Api::V5::PostsController < Api::V4::PostsController
  def index
    if params[:promoted].present?
      @posts = Post.visible.promoted.for_product(ActsAsTenant.current_tenant).includes([:poll])
    else
      if web_request? && some_admin?
        @posts = paginate apply_filters
      else
        @posts = paginate Post.visible.unblocked(current_user.blocked_people).order(created_at: :desc)
      end
      if params[:tag].present? || params[:categories].present?
        @posts = @posts.for_tag(params[:tag]) if params[:tag]
        @posts = @posts.for_category(params[:categories]) if params[:categories]
      elsif params[:person_id].present?
        pid = params[:person_id].to_i
        person = Person.find_by(id: pid)
        if person
          @posts = @posts.for_person(person)
        else
          render_422(_("Cannot find that person.")) && return
        end
      else
        @posts = paginate(Post.visible.following_and_own(current_user).unblocked(current_user.blocked_people).order(created_at: :desc)) unless web_request?
      end
    end
    @post_reactions = current_user.post_reactions.where(post_id: @posts).index_by(&:post_id)
    return_the @posts, handler: tpl_handler
  end

  def create
    if current_user.chat_banned?
      render json: { errors: "You are banned." }, status: :unprocessable_entity
    else
      @post = Post.create(post_params.merge(person_id: current_user.id))
      if @post.valid?
        if params[:post].has_key?(:poll_id)
          @poll = Poll.find(params[:post][:poll_id]).update_attributes(poll_type: Poll.poll_types["post"], poll_type_id: @post.id)
        end
        unless post_params["status"].present?
          @post.published!
        end
        @post.post(@api_version) if @post.published?
        broadcast(:post_created, current_user, @post)
        return_the @post, handler: tpl_handler, using: :show
      else
        render_422 @post.errors
      end
    end
  end
end
