RailsAdmin.config do |config|
  config.included_models.push("Person")
  config.model "Person" do

    list do
      fields :username,
             :email,
             :name,
             :picture,
             :role,
             :created_at,
             :notification_device_ids
    end
    show do
      fields :id, :username, :email, :name, :picture, :role, :designation, :do_not_message_me,
             :pin_messages_from, :auto_follow, :chat_banned, :product_account,
             :recommended, :facebookid, :facebook_picture_url, :created_at, :updated_at #, :level_earned
      field :badges
    end

    edit do
      fields :id, :username, :email
      fields :name, :picture, :role
      fields :designation, :do_not_message_me
      fields :pin_messages_from, :auto_follow
      fields :chat_banned, :product_account
      # fields :recommended, :password
    end
  end
end
# == Schema Information
#
# Table name: people
#
#  id                              :bigint(8)        not null, primary key
#  username_canonical              :text             not null
#  product_id                      :integer          not null
#  crypted_password                :text
#  salt                            :text
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  facebookid                      :text
#  facebook_picture_url            :text
#  picture_file_name               :string
#  picture_content_type            :string
#  picture_file_size               :integer
#  picture_updated_at              :datetime
#  do_not_message_me               :boolean          default(FALSE), not null
#  pin_messages_from               :boolean          default(FALSE), not null
#  reset_password_token            :text
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  product_account                 :boolean          default(FALSE), not null
#  chat_banned                     :boolean          default(FALSE), not null
#  designation                     :jsonb            not null
#  recommended                     :boolean          default(FALSE), not null
#  gender                          :integer          default("unspecified"), not null
#  birthdate                       :date
#  city                            :text
#  country_code                    :text
#  biography                       :text
#  tester                          :boolean          default(FALSE)
#  terminated                      :boolean          default(FALSE)
#  terminated_reason               :text
#  deleted                         :boolean          default(FALSE)
#
