class QuestActivity < ApplicationRecord
    include AttachmentSupport
    include TranslationThings

    has_manual_translated :description, :nam
    belongs_to :quest
    has_many :quest_completions, :foreign_key => "activity_id"
    has_image_called :picture

    def product
        quest.product
    end
end