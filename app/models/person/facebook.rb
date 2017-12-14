class Person
  module Facebook
    def self.included(base)
      base.class_exec do

        def self.create_from_facebook(token, username)
          person = nil
          begin
            graph = Koala::Facebook::API.new(token)
            results = graph.get_object("me", fields: [:id, :email, :picture])
          rescue Koala::Facebook::APIError => e
            Rails.logger.warn("Error contacting facebook for #{username} with token #{token}")
            Rails.logger.warn("Message: #{e.fb_error_message}")
            return nil
          end
          if results && results["id"].present?
            person = Person.create(facebookid: results["id"],
                                username: username,
                                email: results["email"],
                                facebook_picture_url: results.dig("picture", "data", "url"))
          end
          person
        end
      end
    end
  end
end
