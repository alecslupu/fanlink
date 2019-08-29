# == Schema Information
#
# Table name: people
#
#  id                              :bigint(8)        not null, primary key
#  username                        :text             not null
#  username_canonical              :text             not null
#  email                           :text
#  name                            :text
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
#  auto_follow                     :boolean          default(FALSE), not null
#  role                            :integer          default("normal"), not null
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

class Person < ApplicationRecord
  include AttachmentSupport
  include Person::Blocks
  include Person::Badges
  include Person::Facebook
  include Person::Filters
  include Person::Followings
  include Person::Levels
  include Person::Mailing
  include Person::Profile
  include Person::Relationships

  include Person::Trivia

  include TranslationThings
  authenticates_with_sorcery!

  attr_accessor :app

  has_manual_translated :designation

  has_paper_trail

  enum role: %i[ normal staff admin super_admin ]

  normalize_attributes :name, :birthdate, :city, :country_code, :biography, :terminated_reason

  acts_as_tenant(:product)

  belongs_to :product

  has_image_called :picture
  has_many :message_reports, dependent: :destroy
  has_many :notification_device_ids, dependent: :destroy
  has_many :post_reactions, dependent: :destroy
  has_many :room_memberships, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :quest_completions, dependent: :destroy
  has_many :step_completed, dependent: :destroy
  has_many :quest_completed, dependent: :destroy
  has_many :person_rewards, dependent: :destroy
  has_many :person_interests, dependent: :destroy
  has_many :level_progresses, dependent: :destroy
  has_many :reward_progresses, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :pin_messages, dependent: :destroy

  has_many :private_rooms, through: :room_memberships, source: :room
  has_many :pinned_to, through: :pin_messages, source: :room
  has_one :portal_access, dependent: :destroy

  has_many :rewards, through: :person_rewards
  has_many :interests, through: :person_interests
  has_many :event_checkins, dependent: :destroy

  has_many :person_poll_options
  has_many :poll_options, through: :person_poll_options, dependent: :destroy

  has_many :person_certificates
  has_many :certificates, through: :person_certificates, dependent: :destroy

  has_many :course_page_progresses, dependent: :destroy

  has_many :person_certcourses
  has_many :certcourses, through: :person_certcourses, dependent: :destroy

  before_validation :normalize_email
  before_validation :canonicalize_username, if: :username_changed?

  after_commit :flush_cache

  scope :username_filter, -> (query, current_user) { where("people.username_canonical ilike ? AND people.username_canonical != ?", "%#{canonicalize(query.to_s)}%", "#{canonicalize(current_user.username.to_s)}") }
  scope :email_filter, -> (query, current_user) { where("people.email ilike ? AND people.email != ?", "%#{query}%", "#{current_user.email}") }
  scope :product_account_filter, -> (query, current_user) { where("people.product_account = ?", "#{query}") }

  validates :facebookid, uniqueness: { scope: :product_id, allow_nil: true, message: _("A user has already signed up with that Facebook account.") }
  validates :email, uniqueness: { scope: :product_id, allow_nil: true, message: _("A user has already signed up with that email address.") }
  validates :username, uniqueness: { scope: :product_id, message: _("A user has already signed up with that username.") }

  validates :email, presence: { message: _("Email is required.") }, if: Proc.new { |person| person.facebookid.blank? }
  validates :email, email: { message: _("Email is invalid."), allow_nil: true }

  validates :username, presence: { message: _("Username is required.") }
  # validates :username, length: { in: 3..26, message: _("Username must be between 3 and 26 characters") }
  validates :username, format: { without: /[\uFE00-\uFE0F\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9-\u21AA\u231A-\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA-\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614-\u2615\u2618\u261D\u2620\u2622-\u2623\u2626\u262A\u262E-\u262F\u2638-\u263A\u2640\u2642\u2648-\u2653\u2660\u2663\u2665-\u2666\u2668\u267B\u267E-\u267F\u2692-\u2697\u2699\u269B-\u269C\u26A0-\u26A1\u26AA-\u26AB\u26B0-\u26B1\u26BD-\u26BE\u26C4-\u26C5\u26C8\u26CE\u26CF\u26D1\u26D3-\u26D4\u26E9-\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u2709\u270A-\u270B\u270C-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733-\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763-\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934-\u2935\u2B05-\u2B07\u2B1B-\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299\u{1F004}\u{1F0CF}\u{1F170}-\u{1F171}\u{1F17E}\u{1F17F}\u{1F18E}\u{1F191}-\u{1F19A}\u{1F1E6}-\u{1F1FF}\u{1F201}-\u{1F202}\u{1F21A}\u{1F22F}\u{1F232}-\u{1F23A}\u{1F250}-\u{1F251}\u{1F300}-\u{1F320}\u{1F321}\u{1F324}-\u{1F32C}\u{1F32D}-\u{1F32F}\u{1F330}-\u{1F335}\u{1F336}\u{1F337}-\u{1F37C}\u{1F37D}\u{1F37E}-\u{1F37F}\u{1F380}-\u{1F393}\u{1F396}-\u{1F397}\u{1F399}-\u{1F39B}\u{1F39E}-\u{1F39F}\u{1F3A0}-\u{1F3C4}\u{1F3C5}\u{1F3C6}-\u{1F3CA}\u{1F3CB}-\u{1F3CE}\u{1F3CF}-\u{1F3D3}\u{1F3D4}-\u{1F3DF}\u{1F3E0}-\u{1F3F0}\u{1F3F3}-\u{1F3F5}\u{1F3F7}\u{1F3F8}-\u{1F3FF}\u{1F400}-\u{1F43E}\u{1F43F}\u{1F440}\u{1F441}\u{1F442}-\u{1F4F7}\u{1F4F8}\u{1F4F9}-\u{1F4FC}\u{1F4FD}\u{1F4FF}\u{1F500}-\u{1F53D}\u{1F549}-\u{1F54A}\u{1F54B}-\u{1F54E}\u{1F550}-\u{1F567}\u{1F56F}-\u{1F570}\u{1F573}-\u{1F579}\u{1F57A}\u{1F587}\u{1F58A}-\u{1F58D}\u{1F590}\u{1F595}-\u{1F596}\u{1F5A4}\u{1F5A5}\u{1F5A8}\u{1F5B1}-\u{1F5B2}\u{1F5BC}\u{1F5C2}-\u{1F5C4}\u{1F5D1}-\u{1F5D3}\u{1F5DC}-\u{1F5DE}\u{1F5E1}\u{1F5E3}\u{1F5E8}\u{1F5EF}\u{1F5F3}\u{1F5FA}\u{1F5FB}-\u{1F5FF}\u{1F600}\u{1F601}-\u{1F610}\u{1F611}\u{1F612}-\u{1F614}\u{1F615}\u{1F616}\u{1F617}\u{1F618}\u{1F619}\u{1F61A}\u{1F61B}\u{1F61C}-\u{1F61E}\u{1F61F}\u{1F620}-\u{1F625}\u{1F626}-\u{1F627}\u{1F628}-\u{1F62B}\u{1F62C}\u{1F62D}\u{1F62E}-\u{1F62F}\u{1F630}-\u{1F633}\u{1F634}\u{1F635}-\u{1F640}\u{1F641}-\u{1F642}\u{1F643}-\u{1F644}\u{1F645}-\u{1F64F}\u{1F680}-\u{1F6C5}\u{1F6CB}-\u{1F6CF}\u{1F6D0}\u{1F6D1}-\u{1F6D2}\u{1F6E0}-\u{1F6E5}\u{1F6E9}\u{1F6EB}-\u{1F6EC}\u{1F6F0}\u{1F6F3}\u{1F6F4}-\u{1F6F6}\u{1F6F7}-\u{1F6F8}\u{1F6F9}\u{1F910}-\u{1F918}\u{1F919}-\u{1F91E}\u{1F91F}\u{1F920}-\u{1F927}\u{1F928}-\u{1F92F}\u{1F930}\u{1F931}-\u{1F932}\u{1F933}-\u{1F93A}\u{1F93C}-\u{1F93E}\u{1F940}-\u{1F945}\u{1F947}-\u{1F94B}\u{1F94C}\u{1F94D}-\u{1F94F}\u{1F950}-\u{1F95E}\u{1F95F}-\u{1F96B}\u{1F96C}-\u{1F970}\u{1F973}-\u{1F976}\u{1F97A}\u{1F97C}-\u{1F97F}\u{1F980}-\u{1F984}\u{1F985}-\u{1F991}\u{1F992}-\u{1F997}\u{1F998}-\u{1F9A2}\u{1F9B0}-\u{1F9B9}\u{1F9C0}\u{1F9C1}-\u{1F9C2}\u{1F9D0}-\u{1F9E6}\u{1F9E7}-\u{1F9FF}\u23E9-\u23EC\u23F0\u23F3\u25FD-\u25FE\u267F\u2693\u26A1\u26D4\u26EA\u26F2-\u26F3\u26F5\u26FA\u{1F201}\u{1F232}-\u{1F236}\u{1F238}-\u{1F23A}\u{1F3F4}\u{1F6CC}\u{1F3FB}-\u{1F3FF}\u26F9\u{1F385}\u{1F3C2}-\u{1F3C4}\u{1F3C7}\u{1F3CA}\u{1F3CB}-\u{1F3CC}\u{1F442}-\u{1F443}\u{1F446}-\u{1F450}\u{1F466}-\u{1F469}\u{1F46E}\u{1F470}-\u{1F478}\u{1F47C}\u{1F481}-\u{1F483}\u{1F485}-\u{1F487}\u{1F4AA}\u{1F574}-\u{1F575}\u{1F645}-\u{1F647}\u{1F64B}-\u{1F64F}\u{1F6A3}\u{1F6B4}-\u{1F6B6}\u{1F6C0}\u{1F918}\u{1F919}-\u{1F91C}\u{1F91E}\u{1F926}\u{1F933}-\u{1F939}\u{1F93D}-\u{1F93E}\u{1F9B5}-\u{1F9B6}\u{1F9D1}-\u{1F9DD}\u200D\u20E3\uFE0F\u{1F9B0}-\u{1F9B3}\u{E0020}-\u{E007F}\u2388\u2600-\u2605\u2607-\u2612\u2616-\u2617\u2619\u261A-\u266F\u2670-\u2671\u2672-\u267D\u2680-\u2689\u268A-\u2691\u2692-\u269C\u269D\u269E-\u269F\u26A2-\u26B1\u26B2\u26B3-\u26BC\u26BD-\u26BF\u26C0-\u26C3\u26C4-\u26CD\u26CF-\u26E1\u26E2\u26E3\u26E4-\u26E7\u26E8-\u26FF\u2700\u2701-\u2704\u270C-\u2712\u2763-\u2767\u{1F000}-\u{1F02B}\u{1F02C}-\u{1F02F}\u{1F030}-\u{1F093}\u{1F094}-\u{1F09F}\u{1F0A0}-\u{1F0AE}\u{1F0AF}-\u{1F0B0}\u{1F0B1}-\u{1F0BE}\u{1F0BF}\u{1F0C0}\u{1F0C1}-\u{1F0CF}\u{1F0D0}\u{1F0D1}-\u{1F0DF}\u{1F0E0}-\u{1F0F5}\u{1F0F6}-\u{1F0FF}\u{1F10D}-\u{1F10F}\u{1F12F}\u{1F16C}-\u{1F16F}\u{1F1AD}-\u{1F1E5}\u{1F203}-\u{1F20F}\u{1F23C}-\u{1F23F}\u{1F249}-\u{1F24F}\u{1F252}-\u{1F25F}\u{1F260}-\u{1F265}\u{1F266}-\u{1F2FF}\u{1F321}-\u{1F32C}\u{1F394}-\u{1F39F}\u{1F3F1}-\u{1F3F7}\u{1F3F8}-\u{1F3FA}\u{1F4FD}-\u{1F4FE}\u{1F53E}-\u{1F53F}\u{1F540}-\u{1F543}\u{1F544}-\u{1F54A}\u{1F54B}-\u{1F54F}\u{1F568}-\u{1F579}\u{1F57B}-\u{1F5A3}\u{1F5A5}-\u{1F5FA}\u{1F6C6}-\u{1F6CF}\u{1F6D3}-\u{1F6D4}\u{1F6D5}-\u{1F6DF}\u{1F6E0}-\u{1F6EC}\u{1F6ED}-\u{1F6EF}\u{1F6F0}-\u{1F6F3}\u{1F6F9}-\u{1F6FF}\u{1F774}-\u{1F77F}\u{1F7D5}-\u{1F7FF}\u{1F80C}-\u{1F80F}\u{1F848}-\u{1F84F}\u{1F85A}-\u{1F85F}\u{1F888}-\u{1F88F}\u{1F8AE}-\u{1F8FF}\u{1F900}-\u{1F90B}\u{1F90C}-\u{1F90F}\u{1F93F}\u{1F96C}-\u{1F97F}\u{1F998}-\u{1F9BF}\u{1F9C1}-\u{1F9CF}\u{1F9E7}-\u{1FFFD}]/x, message: lambda { |*| _("Username may not contain emojis.") },
  on: :create }

  validates :password, presence: { message: _("Password is required.") }, if: -> { facebookid.blank? && (new_record? || changes[:crypted_password]) }
  validates :password, length: { minimum: 6, allow_blank: true, message: _("Password must be at least 6 characters in length.") }, if: -> { facebookid.blank? && (new_record? || changes[:crypted_password]) }

  validates :name, format: { without: /[\uFE00-\uFE0F\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9-\u21AA\u231A-\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA-\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614-\u2615\u2618\u261D\u2620\u2622-\u2623\u2626\u262A\u262E-\u262F\u2638-\u263A\u2640\u2642\u2648-\u2653\u2660\u2663\u2665-\u2666\u2668\u267B\u267E-\u267F\u2692-\u2697\u2699\u269B-\u269C\u26A0-\u26A1\u26AA-\u26AB\u26B0-\u26B1\u26BD-\u26BE\u26C4-\u26C5\u26C8\u26CE\u26CF\u26D1\u26D3-\u26D4\u26E9-\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u2709\u270A-\u270B\u270C-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733-\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763-\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934-\u2935\u2B05-\u2B07\u2B1B-\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299\u{1F004}\u{1F0CF}\u{1F170}-\u{1F171}\u{1F17E}\u{1F17F}\u{1F18E}\u{1F191}-\u{1F19A}\u{1F1E6}-\u{1F1FF}\u{1F201}-\u{1F202}\u{1F21A}\u{1F22F}\u{1F232}-\u{1F23A}\u{1F250}-\u{1F251}\u{1F300}-\u{1F320}\u{1F321}\u{1F324}-\u{1F32C}\u{1F32D}-\u{1F32F}\u{1F330}-\u{1F335}\u{1F336}\u{1F337}-\u{1F37C}\u{1F37D}\u{1F37E}-\u{1F37F}\u{1F380}-\u{1F393}\u{1F396}-\u{1F397}\u{1F399}-\u{1F39B}\u{1F39E}-\u{1F39F}\u{1F3A0}-\u{1F3C4}\u{1F3C5}\u{1F3C6}-\u{1F3CA}\u{1F3CB}-\u{1F3CE}\u{1F3CF}-\u{1F3D3}\u{1F3D4}-\u{1F3DF}\u{1F3E0}-\u{1F3F0}\u{1F3F3}-\u{1F3F5}\u{1F3F7}\u{1F3F8}-\u{1F3FF}\u{1F400}-\u{1F43E}\u{1F43F}\u{1F440}\u{1F441}\u{1F442}-\u{1F4F7}\u{1F4F8}\u{1F4F9}-\u{1F4FC}\u{1F4FD}\u{1F4FF}\u{1F500}-\u{1F53D}\u{1F549}-\u{1F54A}\u{1F54B}-\u{1F54E}\u{1F550}-\u{1F567}\u{1F56F}-\u{1F570}\u{1F573}-\u{1F579}\u{1F57A}\u{1F587}\u{1F58A}-\u{1F58D}\u{1F590}\u{1F595}-\u{1F596}\u{1F5A4}\u{1F5A5}\u{1F5A8}\u{1F5B1}-\u{1F5B2}\u{1F5BC}\u{1F5C2}-\u{1F5C4}\u{1F5D1}-\u{1F5D3}\u{1F5DC}-\u{1F5DE}\u{1F5E1}\u{1F5E3}\u{1F5E8}\u{1F5EF}\u{1F5F3}\u{1F5FA}\u{1F5FB}-\u{1F5FF}\u{1F600}\u{1F601}-\u{1F610}\u{1F611}\u{1F612}-\u{1F614}\u{1F615}\u{1F616}\u{1F617}\u{1F618}\u{1F619}\u{1F61A}\u{1F61B}\u{1F61C}-\u{1F61E}\u{1F61F}\u{1F620}-\u{1F625}\u{1F626}-\u{1F627}\u{1F628}-\u{1F62B}\u{1F62C}\u{1F62D}\u{1F62E}-\u{1F62F}\u{1F630}-\u{1F633}\u{1F634}\u{1F635}-\u{1F640}\u{1F641}-\u{1F642}\u{1F643}-\u{1F644}\u{1F645}-\u{1F64F}\u{1F680}-\u{1F6C5}\u{1F6CB}-\u{1F6CF}\u{1F6D0}\u{1F6D1}-\u{1F6D2}\u{1F6E0}-\u{1F6E5}\u{1F6E9}\u{1F6EB}-\u{1F6EC}\u{1F6F0}\u{1F6F3}\u{1F6F4}-\u{1F6F6}\u{1F6F7}-\u{1F6F8}\u{1F6F9}\u{1F910}-\u{1F918}\u{1F919}-\u{1F91E}\u{1F91F}\u{1F920}-\u{1F927}\u{1F928}-\u{1F92F}\u{1F930}\u{1F931}-\u{1F932}\u{1F933}-\u{1F93A}\u{1F93C}-\u{1F93E}\u{1F940}-\u{1F945}\u{1F947}-\u{1F94B}\u{1F94C}\u{1F94D}-\u{1F94F}\u{1F950}-\u{1F95E}\u{1F95F}-\u{1F96B}\u{1F96C}-\u{1F970}\u{1F973}-\u{1F976}\u{1F97A}\u{1F97C}-\u{1F97F}\u{1F980}-\u{1F984}\u{1F985}-\u{1F991}\u{1F992}-\u{1F997}\u{1F998}-\u{1F9A2}\u{1F9B0}-\u{1F9B9}\u{1F9C0}\u{1F9C1}-\u{1F9C2}\u{1F9D0}-\u{1F9E6}\u{1F9E7}-\u{1F9FF}\u23E9-\u23EC\u23F0\u23F3\u25FD-\u25FE\u267F\u2693\u26A1\u26D4\u26EA\u26F2-\u26F3\u26F5\u26FA\u{1F201}\u{1F232}-\u{1F236}\u{1F238}-\u{1F23A}\u{1F3F4}\u{1F6CC}\u{1F3FB}-\u{1F3FF}\u26F9\u{1F385}\u{1F3C2}-\u{1F3C4}\u{1F3C7}\u{1F3CA}\u{1F3CB}-\u{1F3CC}\u{1F442}-\u{1F443}\u{1F446}-\u{1F450}\u{1F466}-\u{1F469}\u{1F46E}\u{1F470}-\u{1F478}\u{1F47C}\u{1F481}-\u{1F483}\u{1F485}-\u{1F487}\u{1F4AA}\u{1F574}-\u{1F575}\u{1F645}-\u{1F647}\u{1F64B}-\u{1F64F}\u{1F6A3}\u{1F6B4}-\u{1F6B6}\u{1F6C0}\u{1F918}\u{1F919}-\u{1F91C}\u{1F91E}\u{1F926}\u{1F933}-\u{1F939}\u{1F93D}-\u{1F93E}\u{1F9B5}-\u{1F9B6}\u{1F9D1}-\u{1F9DD}\u200D\u20E3\uFE0F\u{1F9B0}-\u{1F9B3}\u{E0020}-\u{E007F}\u2388\u2600-\u2605\u2607-\u2612\u2616-\u2617\u2619\u261A-\u266F\u2670-\u2671\u2672-\u267D\u2680-\u2689\u268A-\u2691\u2692-\u269C\u269D\u269E-\u269F\u26A2-\u26B1\u26B2\u26B3-\u26BC\u26BD-\u26BF\u26C0-\u26C3\u26C4-\u26CD\u26CF-\u26E1\u26E2\u26E3\u26E4-\u26E7\u26E8-\u26FF\u2700\u2701-\u2704\u270C-\u2712\u2763-\u2767\u{1F000}-\u{1F02B}\u{1F02C}-\u{1F02F}\u{1F030}-\u{1F093}\u{1F094}-\u{1F09F}\u{1F0A0}-\u{1F0AE}\u{1F0AF}-\u{1F0B0}\u{1F0B1}-\u{1F0BE}\u{1F0BF}\u{1F0C0}\u{1F0C1}-\u{1F0CF}\u{1F0D0}\u{1F0D1}-\u{1F0DF}\u{1F0E0}-\u{1F0F5}\u{1F0F6}-\u{1F0FF}\u{1F10D}-\u{1F10F}\u{1F12F}\u{1F16C}-\u{1F16F}\u{1F1AD}-\u{1F1E5}\u{1F203}-\u{1F20F}\u{1F23C}-\u{1F23F}\u{1F249}-\u{1F24F}\u{1F252}-\u{1F25F}\u{1F260}-\u{1F265}\u{1F266}-\u{1F2FF}\u{1F321}-\u{1F32C}\u{1F394}-\u{1F39F}\u{1F3F1}-\u{1F3F7}\u{1F3F8}-\u{1F3FA}\u{1F4FD}-\u{1F4FE}\u{1F53E}-\u{1F53F}\u{1F540}-\u{1F543}\u{1F544}-\u{1F54A}\u{1F54B}-\u{1F54F}\u{1F568}-\u{1F579}\u{1F57B}-\u{1F5A3}\u{1F5A5}-\u{1F5FA}\u{1F6C6}-\u{1F6CF}\u{1F6D3}-\u{1F6D4}\u{1F6D5}-\u{1F6DF}\u{1F6E0}-\u{1F6EC}\u{1F6ED}-\u{1F6EF}\u{1F6F0}-\u{1F6F3}\u{1F6F9}-\u{1F6FF}\u{1F774}-\u{1F77F}\u{1F7D5}-\u{1F7FF}\u{1F80C}-\u{1F80F}\u{1F848}-\u{1F84F}\u{1F85A}-\u{1F85F}\u{1F888}-\u{1F88F}\u{1F8AE}-\u{1F8FF}\u{1F900}-\u{1F90B}\u{1F90C}-\u{1F90F}\u{1F93F}\u{1F96C}-\u{1F97F}\u{1F998}-\u{1F9BF}\u{1F9C1}-\u{1F9CF}\u{1F9E7}-\u{1FFFD}]/x, message: lambda { |*| _("Name may not contain emojis.") },
  on: :create }

  # validates :birthdate, presence: { message: "is required." }

  validate :check_role

  # Check if username has any special characters and if length is between 5 and 25
  validate :valid_username

  # validate :validate_age
  #
  # Return the canonical form of a username.
  #
  # @param [String] username
  #   The incoming username.
  # @return [String]
  #   The canonical version of `username`.
  #
  def self.canonicalize(username)
    StringUtil.search_ify(username)
  end


  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  def jwt_token
    ::TokenProvider.issue_token(user_id: self.id)
  end

  #
  # Lookup a person via their username.
  #
  # @param [String] username
  #   The username to look up.
  # @return [Person]
  #   The person object or `nil`.
  #
  def self.for_username(username)
    self.find_by(username_canonical: canonicalize(username.to_s))
  end

  #
  # Check if someone can login (does not authenticate..sorcery does that).
  #
  # @param [String] email
  #   The email/username.
  # @return [Person]
  #
  def self.can_login?(email)
    email = email.to_s
    query = email.include?("@") ? { email: email.strip.downcase } : { username_canonical: canonicalize(email) }
    Person.find_by(query)
  end

  def device_tokens
    notification_device_ids.map(&:device_identifier)
  end

  #
  # Return a scoped query for people whose names match a string.
  #
  # @param [String] query
  #   What you're looking for in a name.
  # @return [ActiveRecord_Relation]
  #   The scoped query.
  #
  def self.named_like(term)
    where("people.username_canonical ilike ?", "%#{StringUtil.search_ify(term)}%").first
  end

  def self.current_user
    Thread.current[:user]
  end

  def self.current_user=(user)
    Thread.current[:user] = user
  end

  def reset_password_to(password)
    self.password = password
    self.reset_password_token = nil
    self.save
  end

  def set_password_token!
    self.reset_password_token = UUIDTools::UUID.random_create.to_s
    save!
  end

  def permissions
    1
  end

  def roles_for_select
    (product.can_have_supers?) ? Person.roles : Person.roles.except(:super_admin)
  end

  def some_admin?
    !normal?
  end

  def to_s
    name || username
  end

  def title
    username
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  private
    def canonicalize(name)
      self.class.canonicalize(name)
    end

    def canonicalize_username
      if Person.find_by(username_canonical: canonicalize(self.username), product_id: product.id)
        errors.add(:username, :username_in_use, message: _("A user has already signed up with that username."))
        false
      else
        self.username_canonical = canonicalize(self.username)
        true
      end
    end

    def check_role
      if super_admin? && !product.can_have_supers
        errors.add(:role, :role_unallowed, message: _("This product cannot have super admins."))
      end
    end

    def validate_age
      if self.birthdate.present? && ((Date.today.to_s(:number).to_i - self.birthdate.to_date.to_s(:number).to_i) / 10000) < product.age_requirement
        errors.add(:age_requirement, :age_not_met, message: _("Age requirement is not met. You must be %{age_requirement} years or older to use this app.") % { age_requirement: product.age_requirement })
      end
    end

    def normalize_email
      self.email = self.email.strip.downcase if self.email_changed? && self.email.present?
      true
    end

    def valid_username
      if !(/^\w*$/.match(username)) || username.length < 5 || username.length > 25
        errors.add(:username_error, "Username must be 5 to 25 characters with no special characters or spaces")
      end
    end
end
