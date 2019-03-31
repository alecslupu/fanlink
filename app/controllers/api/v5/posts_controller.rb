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
    return_the @posts, handler: 'jb'
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
        return_the @post, handler: 'jb', using: :show
      else
        render_422 @post.errors
      end
    end
  end
  def show
    if current_user.try(:some_admin?) && web_request?
      @post = Post.for_product(ActsAsTenant.current_tenant).find(params[:id])
    else
      @post = Post.for_product(ActsAsTenant.current_tenant).unblocked(current_user.blocked_people).find(params[:id])
      if @post.person != current_user
        @post = @post.visible?
      end
    end

    if @post.nil?
      render_not_found
    else
      @post_reaction = @post.reactions.find_by(person: current_user)
      return_the @post, handler: 'jb', using: :show
    end
  end
end
