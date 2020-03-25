RailsAdmin.config do |config|
  config.included_models.push("Trivia::Round")
  config.model "Trivia::Round" do
    parent "Trivia::Game"
    label_plural "Rounds"
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
      exclude_fields :game
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
