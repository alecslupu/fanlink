class ProductIndex < Chewy::Index
    define_type ActionType do
        field :name
        field :internal_name
        field :active
    end

    define_type ActivityType.includes(:products) do
        field :atype
        field :internal_name
        field :value, type: 'object'
        field :deleted
    end

    define_type Badge do
    end

    define_type Category.includes(:posts) do
    end

    define_type Event.includes(:products) do
    end

    define_type Level.includes(:products) do
    end

    define_type Merchandise do
    end

    define_type MessageMention.includes(:messages, :people) do
    end

    define_type Message.includes(:people, :rooms) do
    end

    define_type Person.includes(:posts, :messages, :rooms) do 
    end

    define_type Post.includes(:people, :tags, :categories) do
    end

    define_type ProductBeacon do
    end

    define_type Product do
        field :name
        field :internal_name
    end

    define_type QuestActivity.includes(:quest) do
    end

    define_type Quest.includes(:steps, :events, :products) do
    end

    define_type Room.includes(:messages) do
    end

    define_type StepCompleted.includes(:steps, :people) do
    end

    define_type Step.includes(:quests) do
    end

    define_type Tag.includes(:posts) do
        field :name
        field :deleted, type: 'boolean'
    end

    
end