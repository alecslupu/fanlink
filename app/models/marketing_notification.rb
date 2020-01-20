# == Schema Information
#
# Table name: marketing_notifications
#
#  id                :bigint(8)        not null, primary key
#  title             :string           not null
#  body              :text             not null
#  person_id         :integer          not null, foreign key
#  ttl_hours         :integer          not null, default: 670
#  person_filter     :integer          not null
#  product_id        :integer          not null, foreign key
#

class MarketingNotification < ApplicationRecord
  belongs_to :person, touch: true

  acts_as_tenant(:product)

  # enum deep_link_action: {
  #   send_to_all: 0,
  #   comments_screen: 1,
  #   profile_screen: 2,
  #   posts_screen: 3,
  #   feed_screen: 4,
  #   profile_screen: 5,
  #   chat_room: 6,
  #   certificate_screen: 7
  # }

  enum person_filter: {
    send_to_all: 0,
    has_certificate_enrolled: 1,
    has_no_certificate_enrolled: 2,
    has_certificate_generated: 3,
    has_paid_certificate: 4,
    has_no_paid_certificate: 5,
    has_friends: 6,
    has_no_friends: 7,
    has_followings: 8,
    has_no_followings: 9,
    has_interests: 10,
    has_no_interests: 11,
    has_created_posts: 12,
    has_no_created_posts: 13,
    has_facebook_id: 14,
    account_created_past_24h: 15,
    accoount_created_past_7_days: 16
  }

  validates :body, presence: true
  validates :title, presence: true
  validates :ttl_hours, presence: true
  validates :deep_link_action, presence: true

  # validate :check_deep_link_pair
  # validate :check_deep_link_value_for_action

  after_create :notify


  private

    def notify
      Delayed::Job.enqueue(MarketingNotificationPushJob.new(id))
    end

    # def check_deep_link_pair
    #   if !send_to_all? && deep_link_value.blank?
    #     errors.add(:deep_link_value, :blank, message: _("cannot be empty when deep link action is #{deep_link_action}"))
    #   end
    # end

    # def check_deep_link_value_for_action
    #   case deep_link_action
    #   when "comments_screen"
    #     error_msg = "posts" unless Post.where(id: deep_link_value).first
    #   when "profile_screen"
    #     error_msg = "people" unless Person.where(id: deep_link_value).first
    #   when "posts_screen"
    #     if Tag.where(id: deep_link_value).first
    #       if Tag.find(deep_link_value).posts.blank?
    #         errors.add(:deep_link_value, :blank, message: _("is incorrect, there are no posts for this tag"))
    #       end
    #     else
    #       error_msg = "tags"
    #     end
    #   when "feed_screen"
    #     error_msg = "people" unless Person.where(id: deep_link_value).first
    #   when "profile_screen"
    #     error_msg = "people" unless Person.where(id: deep_link_value).first
    #   when "chat_room"
    #     error_msg = "rooms" unless Room.where(id: deep_link_value).first
    #   when "comments_screen"
    #     error_msg = "posts" unless Post.where(id: deep_link_value).first
    #   when "certificate_screen"
    #     error_msg = "certificates" unless Certificate.where(id: deep_link_value).first
    #   end

    #   errors.add(:deep_link_value, :blank, message: _("is incorrect, there are no #{error_msg} for this value")) if error_msg
    # end
end


# fa validare ca daca ai action dif de send to all deep link value trb sa aiba o valoare, verifica si daca e tipul corect!!!! si poti cauta si resource, sa vezi daca valoarea e ok
# si daca e send_to_all fa deep link value nil
