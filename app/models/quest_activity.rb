class QuestActivity < ApplicationRecord
    include AttachmentSupport
    include TranslationThings

    has_manual_translated :description, :name
    has_many :quest_completions, :foreign_key => "activity_id"
    has_many :activity_types, -> { order(created_at: :desc) }, :foreign_key => "activity_id"
    belongs_to :step
    has_image_called :picture
    
    #default_scope { order(created_at: :desc) }


    scope :with_completion, -> (person) { where("quest_completions.person_id = ?", person.id) }

    def product
        step.quest.product
    end

end