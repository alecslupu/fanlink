RailsAdmin.config do |config|
  config.included_models.push("Trivia::Round")
  config.model "Trivia::Round" do
    parent "Trivia::Game"
    label_plural "Rounds"

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
      fields :status, :complexity
      field :start_date, :unix_timestamp
      field :questions do
        def render
          bindings[:view].render partial: "rails_admin/main/form_nested_many_orderable", locals: {
            field: self, form: bindings[:form], field_order: :question_order_field
          }
        end
      end
    end
    nested do
      fields :status, :complexity
      field :start_date, :unix_timestamp
      field :questions do
        visible { bindings[:object].persisted? }

        def render
          bindings[:view].render partial: "rails_admin/main/form_nested_many_orderable", locals: {
            field: self, form: bindings[:form], field_order: :question_order_field
          }
        end
      end
    end
  end
end
