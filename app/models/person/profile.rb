class Person
  enum gender: %i[ unspecified male female ]

  validate :valid_country_code
  validates :country_code, length: { is: 2 }, allow_nil: true

  module Profile
    def country_code=(c)
      write_attribute :country_code, (c.nil?) ? nil : c.upcase
    end

    def valid_country_code
      if country_code.present? && ISO3166::Country.find_country_by_alpha2(country_code).nil?
        errors.add(:country_code, :invalid_country_code, message: _("Country code '%{country_code}' is invalid"))
      end
    end
  end
end
