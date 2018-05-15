class QuestActivity < ApplicationRecord
    include AttachmentSupport
    include TranslationThings

    has_manual_translated :description, :nam
    belongs_to :quest
    has_many :quest_completions, :foreign_key => "activity_id"
    belongs_to :product_beacon, :foreign_key => "beacon"
    has_image_called :picture

    scope :with_completion, -> (person) { where("quest_completions.person_id = ?", person.id) }

    def product
        quest.product
    end
end