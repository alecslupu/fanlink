class Api::V4::PostsController < Api::V3::PostsController
  def index
    if params[:promoted].present? && params[:promoted] == "true"
      @posts = Post.visible.promoted.for_product(ActsAsTenant.current_tenant).includes([:poll])
    else
      if web_request? && some_admin?
        @posts = paginate apply_filters
      else
        @posts = paginate Post.not_promoted.visible.unblocked(current_user.blocked_people).order(created_at: :desc)
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
        @posts = paginate(Post.visible.not_promoted.following_and_own(current_user).unblocked(current_user.blocked_people).order(created_at: :desc)) unless web_request?
      end
    end
    @post_reactions = current_user.post_reactions.where(post_id: @posts).index_by(&:post_id)
    # @posts = @posts.includes([:person])
    return_the @posts, handler: tpl_handler
  end

  def list
    @posts = paginate apply_filters
    @posts = @posts.for_tag(params[:tag]) if params[:tag]
    @posts = @posts.for_categories(params[:categories]) if params[:categories]
    return_the @posts, handler: tpl_handler
  end

  # def promoted
  #   @posts = Post.promoted
  #   return_the @posts, handler: tpl_handler
  # end

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
      return_the @post, handler: tpl_handler, using: :show
    end
  end

  def share
    product = get_product
    if product.nil?
      render_422(_("Missing or invalid product."))
    else
      @post = Post.for_product(product).visible.find(params[:post_id])
      return_the @post, handler: tpl_handler
    end
  end

  def create
    if current_user.chat_banned?
      render json: { errors: "You are banned." }, status: :unprocessable_entity
    else
      @post = Post.create(post_params.merge(person_id: current_user.id))
      if @post.valid?
        if post_params["status"].blank?
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

  def update
    if params.has_key?(:post)
      if @post.update(post_params)
        render :show
      else
        render_422 @post.errors
      end
    else
      render :show
    end
  end

  def stats
    if params.has_key?(:days) && params[:days].respond_to?(:to_i)
      time = params[:days].to_i
    else
      time = 1
    end
    @posts = Post.where("created_at >= ?", time.day.ago).order("DATE(created_at) ASC").group("Date(created_at)").count
    return_the @posts, handler: tpl_handler
  end

  protected

    def tpl_handler
      :jb
    end
end
