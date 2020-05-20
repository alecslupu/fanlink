# frozen_string_literal: true
class Api::V4::Trivia::SubscriptionsController < ApiController
  def show
    @subscriber = datasource.first!
    return_the @subscriber, handler: tpl_handler
  end

  def update
    @subscriber = datasource.first!
    if @subscriber.update(subscribed: params[:subscribed] || false)
      game_topic_subscription(params[:subscribed])
      return_the @subscriber, handler: tpl_handler
    else
      render_422 @subscriber.errors
    end
  end

  def destroy
    @subscriber = datasource.first!
    if @subscriber.destroy
      @subscriber.unsubscribe_from_game_topic(current_user.id, @subscriber.game_id)
      head :ok && return
    end
  end

  def create
    @subscriber = datasource.first_or_initialize(subscribed: params[:subscribed] || false)
    if @subscriber.save!
      @subscriber.subscribe_to_game_topic(current_user.id, params[:game_id]) if params[:subscribed]
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

  def game_topic_subscription(subscribed)
    if subscribed
      @subscriber.subscribe_to_game_topic(current_user.id, @subscriber.game_id)
    elsif subscribed == false
      @subscriber.unsubscribe_from_game_topic(current_user.id, @subscriber.game_id)
    end
  end

  def tpl_handler
    :jb
  end
end
