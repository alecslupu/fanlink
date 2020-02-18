module RailsAdmin
  module Config
    module Actions
      module Referral
        class ReportAction < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(:referral_report_action, self)

          register_instance_option :collection do
            true
          end

          register_instance_option :http_methods do
            [:get]
          end

          register_instance_option :route_fragment do
            :report
          end

          register_instance_option :template_name do
            :report_action
          end

          register_instance_option :controller do
            proc do
              @objects = Person.
                joins(:referrals).
                select("people.*, COUNT(#{Arel.sql(::Referral::ReferredPerson.table_name)}.id) as referral_count").
                group("people.id").
                order("referral_count DESC")

              if params[:f].present?
                params[:f].each_pair do |field_name, filters_dump|
                  filters_dump.each do |_, filter_dump|
                    if field_name == "referral_referred_people.created_at"
                      value = if filter_dump[:v].is_a?(Array)
                        filter_dump[:v].map { |v| RailsAdmin::Support::Datetime.new("%B %d, %Y %H:%M").parse_string(v) }
                      else
                        RailsAdmin::Support::Datetime.new(strftime_format).parse_string(filter_dump[:v])
                      end
                      conditions = RailsAdmin::Adapters::ActiveRecord::StatementBuilder.new(field_name, :datetime, value, (filter_dump[:o] || 'default')).to_statement

                      @objects = @objects.send(:where, conditions)

                    end
                    if field_name == "inviter"
                      value = filter_dump[:v].is_a?(Array) ? filter_dump[:v].map { |v| v } : filter_dump[:v]
                      conditions1 = RailsAdmin::Adapters::ActiveRecord::StatementBuilder.new("people.username", :string, value, (filter_dump[:o] || 'default')).to_statement
                      conditions2 = RailsAdmin::Adapters::ActiveRecord::StatementBuilder.new("referral_user_codes.unique_code", :string, value, (filter_dump[:o] || 'default')).to_statement

                      # Not a pretty one
                      if conditions1.present? && conditions2.present?
                        @objects = @objects.joins(:referral_code)
                        @objects = @objects.where("(#{conditions1.first} or #{conditions2.first})", conditions1.last, conditions2.last)
                      end
                    end
                  end
                end
              end

              # if params[:page] && params[:per]
                @objects = @objects.send(Kaminari.config.page_method_name, params[:page]).per(params[:per])
              # end


              # @objects = paginate @objects
            end
          end

        end
      end
    end
  end
end
