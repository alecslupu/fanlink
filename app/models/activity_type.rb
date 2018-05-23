class ActivityType < ApplicationRecord
    include ActivityType::Beacon
    include ActivityType::Post
    include ActivityType::Image
    include ActivityType::Audio

    
    enum type: %i[ beacon image audio post activity_code ] 
    belongs_to :quest_activity, :foreign_key => "activity_id"

    #default_scope { order(created_at: :desc) }

private
    
end
