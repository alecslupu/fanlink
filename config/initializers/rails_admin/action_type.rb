# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push("ActionType")

  config.model "ActionType" do
    list do
      items_per_page 100
      sort_by :name

      fields :id, :name, :internal_name, :active
      field :in_use, :boolean do
        pretty_value do
          value = bindings[:object].in_use?
          case value
          when false
            %(<span class='label label-danger'>&#x2718;</span>)
          when true
            %(<span class='label label-success'>&#x2713;</span>)
          else
            %(<span class='label label-default'>&#x2012;</span>)
          end.html_safe
        end
      end

      fields :seconds_lag

      field :created_at do
        date_format :short
      end
    end
    edit do
      fields :name, :internal_name, :active, :seconds_lag
      # , :badges, :rewards

      # field :badge_actions_count do
      #   read_only true
      # end
      # field :badges_count do
      #   read_only true
      # end
    end
    show do
      fields :id,
             :name,
             :internal_name,
             :active,
             :seconds_lag
    end
  end
end
