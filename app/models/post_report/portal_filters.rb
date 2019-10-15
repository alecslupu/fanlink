module PostReport::PortalFilters
  extend ActiveSupport::Concern

  included do
    scope :status_filter, -> (query) { where(status: query.to_sym) }
  end
end
