module RailsAdmin
  module Config
    module Actions
      module Referral
        class PurchaseReportAction < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(:referral_purchase_report_action, self)


          register_instance_option :collection do
            true
          end

          register_instance_option :http_methods do
            [:get]
          end

          register_instance_option :route_fragment do
            :purchase_report
          end

          register_instance_option :template_name do
            :report_action
          end

          register_instance_option :controller do
            proc do
	      @objects = Person.
                joins(referred_people: :certificates).
                select("people.*, COUNT(DISTINCT #{Arel.sql(::Referral::ReferredPerson.table_name)}.id) as refferal_count, SUM(person_certificates.amount_paid) as amount").
                where(certificates: {is_free: false}).
                group("people.id").
                order("refferal_count DESC")

              if params[:f].present?
                params[:f].each_pair do |field_name, filters_dump|
                  filters_dump.each do |_, filter_dump|
                    if field_name == "person_certificates.created_at"
                      value = if filter_dump[:v].is_a?(Array)
                        filter_dump[:v].map { |v| RailsAdmin::Support::Datetime.new("%B %d, %Y %H:%M").parse_string(v) }
                      else
                        RailsAdmin::Support::Datetime.new(strftime_format).parse_string(filter_dump[:v])
                      end
                      conditions = RailsAdmin::Adapters::ActiveRecord::StatementBuilder.new(field_name, :datetime, value, (filter_dump[:o] || 'default')).to_statement

                      @objects = @objects.send(:where, conditions)

                    end
                  end
                end
              end

              # if params[:page] && params[:per]
              @objects = @objects.send(Kaminari.config.page_method_name, params[:page]).per(params[:per])
              # end
	    end
          end

        end
      end
    end
  end
end
