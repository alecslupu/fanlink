# frozen_string_literal: true

module RailsAdmin
  module Config
    module Fields
      module Types
        class UnixTimestamp < RailsAdmin::Config::Fields::Types::Datetime
          # Register field type for the type loader
          RailsAdmin::Config::Fields::Types.register(self)

          def parse_value(value)
            Rails.logger.debug("got here #{__LINE__ }")
            super
          end

          def parse_input(params)
            Rails.logger.debug("got here #{__LINE__ }")
            super
          end

          def value
            parent_value = super
            if %(Integer).include?(parent_value.class.name)
              parent_value = ::Time.zone.at(parent_value)
            end

            if %w(DateTime Date Time).include?(parent_value.class.name)
              parent_value.in_time_zone
            else
              parent_value
            end
          end
        end
      end
    end
  end
end
