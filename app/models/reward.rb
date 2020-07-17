# frozen_string_literal: true

# == Schema Information
#
# Table name: rewards
#
#  id                     :bigint           not null, primary key
#  product_id             :integer          not null
#  untranslated_name      :jsonb            not null
#  internal_name          :text             not null
#  reward_type            :integer          default("badge"), not null
#  reward_type_id         :integer          not null
#  series                 :text
#  completion_requirement :integer          default(1), not null
#  points                 :integer          default(0)
#  status                 :integer          default("active"), not null
#  deleted                :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Reward < ApplicationRecord
  include Reward::Badges
  include Reward::Contests
  include Reward::Coupons
  include Reward::Urls
  enum reward_type: %i[badge url coupon]
  enum status: %i[active inactive]

  scope :for_product, ->(product) { where(rewards: { product_id: product.id }) }

  acts_as_tenant(:product)

  belongs_to :product
  belongs_to :badge, foreign_key: 'reward_type_id', foreign_type: 'reward_type', optional: true
  belongs_to :url, foreign_key: 'reward_type_id', foreign_type: 'reward_type', optional: true
  belongs_to :coupon, foreign_key: 'reward_type_id', foreign_type: 'reward_type', optional: true

  has_many :assigned_rewards
  has_many :person_rewards
  has_many :reward_progresses

  has_many :quests, through: :assigned_rewards, source: :assigned, source_type: 'Quest'
  has_many :steps, through: :assigned_rewards, source: :assigned, source_type: 'Step'
  has_many :quest_activities, through: :assigned_rewards, source: :assigned, source_type: 'QuestActivity'
  has_many :action_types, through: :assigned_rewards, source: :assigned, source_type: 'ActionType'

  has_many :people, through: :person_rewards

  # has_manual_translated :name

  translates :name, touch: true, versioning: :paper_trail
  accepts_nested_attributes_for :translations, allow_destroy: true

  has_paper_trail

  normalize_attributes :series

  validates :internal_name,
            presence: { message: _('Internal name is required.') },
            format: { with: /\A[a-z_0-9]+\z/, message: lambda { |*| _('Internal name can only contain lowercase letters, numbers and underscores.') } },
            length: { in: 3..26, message: _('Internal name must be between 3 and 26 characters.') },
            uniqueness: { scope: :product_id, message: _('There is already a reward with that internal name.') }
  validates :series,
            format: { with: /\A[a-z_0-9]+\z/, message: lambda { |*| _('Series can only contain lowercase letters, numbers and underscores.') } },
            length: { in: 3..26, message: _('Series must be between 3 and 26 characters.') },
            allow_blank: true
  validates_uniqueness_of :reward_type_id, scope: :reward_type, message: _('A reward with that reward_type and reward_type_id already exists.')
end
