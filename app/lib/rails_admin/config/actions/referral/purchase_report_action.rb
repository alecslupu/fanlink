# frozen_string_literal: true

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
                         select("people.*, COUNT(DISTINCT #{Arel.sql(::Referral::ReferredPerson.table_name)}.id) as referral_count, SUM(person_certificates.amount_paid)/100 as amount").
                         where(certificates: { is_free: false }).
                         group('people.id').
                         order('referral_count DESC')

              if params[:f].present?
                params[:f].each_pair do |field_name, filters_dump|
                  filters_dump.each do |_, filter_dump|
                    if field_name == 'person_certificates.created_at'
                      value = if filter_dump[:v].is_a?(Array)
                                filter_dump[:v].map { |v| RailsAdmin::Support::Datetime.new('%B %d, %Y %H:%M').parse_string(v) }
                              else
                                RailsAdmin::Support::Datetime.new(strftime_format).parse_string(filter_dump[:v])
                              end
                      conditions = RailsAdmin::Adapters::ActiveRecord::StatementBuilder.new(field_name, :datetime, value, (filter_dump[:o] || 'default')).to_statement

                      @objects = @objects.send(:where, conditions)

                    end
                    if field_name == 'person_certificates.amount_paid'
                      value = filter_dump[:v].is_a?(Array) ? filter_dump[:v].map { |v| v } : filter_dump[:v]
                      conditions = RailsAdmin::Adapters::ActiveRecord::StatementBuilder.new(field_name, :float, value, (filter_dump[:o] || 'default')).to_statement
                      if conditions.is_a?(Array)
                        conditions = [conditions[0].gsub(field_name, "SUM(#{field_name})/100"), *conditions.drop(1).collect(&:to_i)]
                      end

                      Rails.logger.debug conditions.inspect
                      @objects = @objects.send(:having, conditions)
                    end
                    if field_name == 'inviter'
                      value = filter_dump[:v].is_a?(Array) ? filter_dump[:v].map { |v| v } : filter_dump[:v]
                      conditions1 = RailsAdmin::Adapters::ActiveRecord::StatementBuilder.new('people.username', :string, value, (filter_dump[:o] || 'default')).to_statement
                      conditions2 = RailsAdmin::Adapters::ActiveRecord::StatementBuilder.new('referral_user_codes.unique_code', :string, value, (filter_dump[:o] || 'default')).to_statement

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
            end
          end
        end
      end
    end
  end
end
