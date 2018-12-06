class Api::V4::PostsController < Api::V3::PostsController
  def index
    if @req_source == "web" && current_user.some_admin?
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
      @posts = paginate(Post.visible.following_and_own(current_user).unblocked(current_user.blocked_people).order(created_at: :desc)) unless @req_source == "web"
    end
    @post_reactions = current_user.post_reactions.where(post_id: @posts).index_by(&:post_id)
    # @posts = @posts.includes([:category, :person])
    return_the @posts, handler: 'jb'
  end

  def list
    @posts = paginate apply_filters
    @posts = @posts.for_tag(params[:tag]) if params[:tag]
    @posts = @posts.for_categories(params[:categories]) if params[:categories]
    return_the @posts, handler: 'jb'
  end

  def show
    if current_user.try(:some_admin?) && @req_source == "web"
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

  def share
    product = get_product
    if product.nil?
      render_422(_("Missing or invalid product."))
    else
      @post = Post.for_product(product).visible.find(params[:post_id])
      return_the @post, handler: 'jb'
    end
  end

  def create
    if current_user.chat_banned?
      render json: { errors: "You are banned." }, status: :unprocessable_entity
    else
      @post = Post.create(post_params.merge(person_id: current_user.id))
      if @post.valid?
        unless post_params["status"].present?
          @post.published!
        end
        @post.post if @post.published?
        broadcast(:post_created, current_user, @post)
        return_the @post, handler: 'jb', using: :show
      else
        render_422 @post.errors
      end
    end
  end

  def update
    if params.has_key?(:post)
      if @post.update_attributes(post_params)
        return_the @post, handler: 'jb', using: :show
      else
        render_422 @post.errors
      end
    else
      return_the @post, handler: 'jb', using: :show
    end
  end

  def stats
    if params.has_key?(:days) && params[:days].respond_to?(:to_i)
      time = params[:days].to_i
    else
      time = 1
    end
    @posts = Post.where("created_at >= ?", time.day.ago).order("DATE(created_at) ASC").group("Date(created_at)").count
    return_the @posts, handler: 'jb'
  end

end
