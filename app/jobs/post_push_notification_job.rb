# frozen_string_literal: true
class PostPushNotificationJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    person = post.person
    ActsAsTenant.with_tenant(person.product) do
      Push::PostForFollowers.new.push(person, post.id)
    end
  end
end
