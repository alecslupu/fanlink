# https://github.com/thiagopradi/octopus/issues/241
if Octopus.enabled?
  module Delayed
    module Backend
      module ActiveRecord
        class Job < ::ActiveRecord::Base
          class << self
            alias_method :reserve_without_octopus, :reserve
            def reserve(worker, max_run_time = Worker.max_run_time)
              Octopus.using(:master) do
                reserve_without_octopus(worker, max_run_time)
              end
            end
          end
        end
      end
    end
  end
end