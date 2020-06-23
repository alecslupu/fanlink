# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('Trivia::AvailableQuestion')
  config.model 'Trivia::AvailableQuestion' do
    parent 'Trivia::Game'

    label_plural 'Available questions'

    configure :status, :enum do
      queryable false
      # this does not work with RA 1.3.0
      # enum_method :rails_admin_status_field
      enum do
        if bindings[:object].new_record?
          { draft: bindings[:object].class.statuses[:draft] }
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
      fields :title, :cooldown_period, :time_limit, :topic, :complexity, :status

      field :type, :enum do
        enum do
          [
            ['Single Choice', 'Trivia::SingleChoiceAvailableQuestion'],
            ['Multiple Choice', 'Trivia::MultipleChoiceAvailableQuestion'],
            ['Picture Choice', 'Trivia::PictureAvailableQuestion'],
            ['True or False', 'Trivia::BooleanChoiceAvailableQuestion'],
            ['Fill in the blanks', 'Trivia::HangmanAvailableQuestion'],
          ]
        end
        read_only { bindings[:object].persisted? }
      end
      field :available_answers
    end
    nested do
      field :type, :enum do
        read_only { bindings[:object].persisted? }
      end
    end
  end
end
