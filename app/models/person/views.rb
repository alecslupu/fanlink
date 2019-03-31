module Person::Views
  extend ActiveSupport::Concern
  included do
    api_accessible :person_v1_base do |t|
      t.add lambda{|person| person.id.to_s}, as: :id

    end
    def around_api_response(api_template)
      Rails.cache.fetch("api_response_#{self.class.to_s}_#{id}_#{api_template.to_s}_#{updated_at}", expires_in: 1.hour) do
        yield
      end
    end
  end
end
