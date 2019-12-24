class Api::V4::Trivia::SubscriptionsController < ApiController
  def show
    @subscriber = datasource.first!
    return_the @subscriber, handler: tpl_handler
  end

  def update
    @subscriber = datasource.first!
    if @subscriber.update(subscribed: params[:subscribed] || false)
      return_the @subscriber, handler: tpl_handler
    else
      render_422 @subscriber.errors
    end
  end

  def destroy
    @subscriber = datasource.first!
    if @subscriber.destroy
      head :ok && return
    end
  end

  def create
    @subscriber = datasource.first_or_initialize(subscribed: params[:subscribed] || false)
    if @subscriber.save!
      return_the @subscriber, handler: tpl_handler, using: :show
    else
      render_422 @subscriber.errors.full_messages.to_sentence
    end
  end

  protected

  def datasource
    game = ::Trivia::Game.find(params[:game_id])
    game.subscribers.where(person_id: current_user.id)
  end

  def tpl_handler
    :jb
  end
end
