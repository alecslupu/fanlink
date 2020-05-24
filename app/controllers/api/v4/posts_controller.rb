# frozen_string_literal: true
class Api::V4::PostsController < Api::V3::PostsController
  def index
    ordering = 'DESC'
    if chronological?
      post = Post.find(params[:post_id])
      if params[:chronologically] == "after"
        sign = '>'
        ordering = 'ASC'
      else
        sign = '<'
      end
    end
    if params[:promoted].present? && params[:promoted] == "true"
      @posts = Post.visible.promoted.for_product(ActsAsTenant.current_tenant).includes([:poll])
      @posts = @posts.chronological(sign, post.created_at, post.id) if chronological?
    else
      if web_request? && some_admin?
        @posts = apply_filters
      else
        @posts = Post.visible.unblocked(current_user.blocked_people).includes([:poll])
        @posts = @posts.chronological(sign, post.created_at, post.id) if chronological?
      end
      @posts = paginate @posts

      if params[:tag].present? || params[:categories].present?
        @posts = @posts.tagged_with(params[:tag]) if params[:tag]
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
        unless web_request?
          @posts = Post.visible.following_and_own(current_user).unblocked(current_user.blocked_people).includes([:poll])
          @posts = @posts.chronological(sign, post.created_at, post.id) if chronological?
          @posts = paginate(@posts)
        end
      end
    end
    @posts = @posts.order(Arel.sql("posts.created_at #{ordering}, posts.id #{ordering} "))
    @post_reactions = current_user.post_reactions.where(post_id: @posts).index_by(&:post_id)

    # @posts = @posts.includes([:person])
    return_the @posts, handler: tpl_handler
  end

  def list
    @posts = paginate apply_filters
    @posts = @posts.tagged_with(params[:tag]) if params[:tag]
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
    @posts = Post.where("created_at >= ?", time.day.ago).order(Arel.sql("DATE(created_at) ASC")).group(Arel.sql("Date(created_at)")).count
    return_the @posts, handler: tpl_handler
  end

  protected
  def apply_filters
    posts = Post.for_product(ActsAsTenant.current_tenant)

    posts = if chronological?
              posts.chronological(sign, post.created_at, post.id)
            else
              posts.order(created_at: :desc)
            end
    params.each do |p, v|
      if p.end_with?("_filter") && Post.respond_to?(p)
        posts = posts.send(p, v)
      end
    end
    posts
  end

  def chronological?
    params[:post_id].present? && %w[before after].include?(params[:chronologically])
  end

  def tpl_handler
    :jb
  end
end
