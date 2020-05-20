# frozen_string_literal: true
class Api::V4::PostReactionsController < Api::V3::PostReactionsController
  def create
    parms = post_reaction_params
    if @post.person.try(:product) == current_user.product
      @post_reaction = @post.reactions.create(parms)
      if @post_reaction.valid?
        return_the @post_reaction, handler: tpl_handler, using: :show
      else
        render_422 @post_reaction.errors
      end
    else
      render_not_found
    end
  end

  def update
    if params.has_key?(:post_reaction)
      if @post_reaction.person == current_user
        if @post_reaction.update(post_reaction_params)
          return_the @post_reaction, handler: tpl_handler
        else
          render_422 @post_reaction.errors
        end
      else
        render_not_found
      end
    else
      return_the @post_reaction, handler: tpl_handler, using: :show
    end
  end

  protected

    def tpl_handler
      :jb
    end
end
