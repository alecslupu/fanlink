# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('Trivia::Game')

  config.model 'Trivia::Game' do
  #   navigation_label "Trivia"
    label_plural 'Trivia Games'

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

    list do
      fields :id, :description, :round_count, :long_name, :status
      field :start_date, :unix_timestamp
    end

    edit do
      fields :short_name, :long_name, :description, :room, :leaderboard_size, :picture, :status
      field :start_date, :unix_timestamp do
        read_only { true }
      end
      field :prizes do
        visible { bindings[:object].persisted? }
      end
      field :rounds do
        visible { bindings[:object].persisted? }
      end
    end
    show do
      fields :short_name, :long_name, :description, :room, :status
      fields :leaderboard_size, :picture
      field :start_date, :unix_timestamp
      fields :prizes, :rounds
    end
  end

end
