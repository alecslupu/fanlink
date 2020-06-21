# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push("Trivia::MultipleChoiceAvailableQuestion")
  config.model "Trivia::MultipleChoiceAvailableQuestion" do
    parent "Trivia::AvailableQuestion"
    label_plural "Multiple choice"

    configure :status, :enum do
      queryable false
      # this does not work with RA 1.3.0
      # enum_method :rails_admin_status_field
      enum do
        if bindings[:object].new_record?
          {draft: bindings[:object].class.statuses[:draft]}
        else
          ha = {}
          bindings[:object].aasm.states(permitted: true).map(&:name).
            push(bindings[:object].status).
            map { |c| ha[c] = bindings[:object].class.statuses[c] }
          ha
        end
      end
      default_value :draft
    end

    edit do
      fields :title, :cooldown_period, :time_limit, :topic, :complexity, :status, :available_answers
    end
  end
end
