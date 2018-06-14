class Reward < ApplicationRecord
    enum reward_type: %i[ badge url coupon points ]
    enum status: %i[ active disabled deleted]

    acts_as_tenant(:product)
  
    belongs_to :product
    has_many :assigned_rewards
    has_many :person_rewards

    has_many :quests, through: :assigned_rewards, source: :assigned, source_type: 'Quest'
    has_many :steps, through: :assigned_rewards, source: :assigned, source_type: 'Step'
    has_many :quest_activities, through: :assigned_rewards, source: :assigned, source_t ype: 'QuestActivity'

    has_many :people, through: :person_rewards

    validates :internal_name,
        presence: true,
        format: { with: /\A[a-z_0-9]+\z/, message: lambda { |*| _("Internal name can only contain lowercase letters, numbers and underscores.") } },
        length: { in: 3..26 },
        uniqueness: { scope: :product_id, message: "There is already a reward with that internal name." }
end