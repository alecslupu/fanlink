module Post::Views
  extend ActiveSupport::Concern
  included do
    api_accessible :post_v1_base do |t|
      t.add :id
      t.add lambda{|post| post.created_at.to_s}, as: :create_time
      t.add lambda{|post| post.body(@lang)}, as: :body
      t.add :picture_optimal_url, as: :picture_url
      t.add :audio_url
      t.add :audio_file_size, as: :audio_file_size
      t.add :audio_content_type
      t.add lambda{|post| post.person }, as: :person
      # post_reaction_counts: post.reaction_breakdown.to_json,
      # post_reaction_counts: post.reaction_breakdown,
      t.add :global
      t.add lambda{|post| ((post.starts_at.nil?) ? nil : post.starts_at.to_s) }, as: :starts_at
      t.add lambda{|post| ((post.ends_at.nil?) ? nil : post.ends_at.to_s)}, as: :ends_at
      t.add :repost_interval
      t.add :status
      t.add :priority
      t.add :recommended
      t.add :notify_followers
      t.add :post_comments_count
    end

    api_accessible :post_v2_base, extend: :post_v1_base do |t|
    end

    api_accessible :post_v3_base, extend: :post_v2_base do |t|
    end

    api_accessible :post_v4_base, extend: :post_v3_base do |t|
      t.add :video_url
      t.add :video_transcoded
      t.add :video_thumbnail
    end

    api_accessible :post_v5_base, extend: :post_v4_base do |t|
    end

    def around_api_response(api_template)
      Rails.cache.fetch("api_response_#{self.class.to_s}_#{id}_#{api_template.to_s}_#{updated_at}", expires_in: 1.hour) do
        yield
      end
    end
  end
end
