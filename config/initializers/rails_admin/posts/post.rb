# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('Post')
  config.included_models.push('Post::Translation')

  config.model 'Post::Translation' do
    visible false
    configure :locale, :hidden do
      help ''
    end
    include_fields :locale, :body
    #
    # edit do
    #   field :locale, :body
    # end
    export do
      fields :locale, :body
    end
  end

  config.model 'Post' do
    navigation_label 'Posts'
    configure :translations, :globalize_tabs
    configure :reported do
    end
    configure :id do
      label 'Post ID'
    end
    list do
      scopes [nil, :reported, :not_reported]

      field :person do
        column_width 75
      end
      field :id do
        column_width 30
      end
      field :body do
        searchable [{post_translations: :body}]
        queryable true
        column_width 150
      end
      field :picture do
        column_width 30
      end
      field :global do
        column_width 30
      end
      field :recommended do
        column_width 30
      end
      field :starts_at do
        column_width 30
      end
      field :ends_at do
        column_width 30
      end
      field :repost_interval do
        column_width 30
      end
      field :status do
        column_width 30
      end
      field :priority do
        column_width 30
      end
      field :reported do
        column_width 30
        pretty_value do
          bindings[:object].reported?
        end
        export_value do
          bindings[:object].reported?
        end
      end
      field :created_at do
        column_width 60
      end
    end
    show do
      fields :translations,
             :person,
             :id,
             :picture,
             :global,
             :recommended,
             :starts_at,
             :ends_at,
             :repost_interval,
             :status,
             :priority
    end
    edit do
      fields :translations,
            :person,
            :picture,
            :global,
            :recommended,
            :starts_at,
            :ends_at,
            :repost_interval,
            :status,
            :priority
      # field :person_ do
      #   default_value do
      #     if bindings[:view]._current_user.try(:product_id) == ActsAsTenant.current_tenant.id
      #       bindings[:view]._current_user
      #     else
      #       ActsAsTenant.current_tenant.people.where(role: 'admin').first
      #     end
      #   end
      # end
    end

    export do
      fields :id, :global, :starts_at, :ends_at, :repost_interval,
             :status, :created_at, :updated_at, :priority, :recommended,
             :notify_followers,  :post_comments_count, :pinned, :translations

      # field :picture do
      #   # export_value do
      #   #   bindings[:object].picture_url
      #   # end
      # end
      # field :video do
      #   # export_value do
      #   #   bindings[:object].video_url
      #   # end
      # end
      # field :audio do
      #   # export_value do
      #   #   bindings[:object].audio_url
      #   # end
      # end

      field :reported do
        export_value do
          bindings[:object].reported?
        end
      end
      fields :person, :post_comments, :post_reports, :poll, :poll_options

    end
  end
end
