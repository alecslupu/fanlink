# https://github.com/thiagopradi/octopus/issues/241
# if Octopus.enabled?
#   module Delayed
#     module Backend
#       module ActiveRecord
#         class Job < ::ActiveRecord::Base
#           class << self
#             alias_method :reserve_without_octopus, :reserve
#             def reserve(worker, max_run_time = Worker.max_run_time)
#               Octopus.using(:master) do
#                 reserve_without_octopus(worker, max_run_time)
#               end
#             end
#           end
#         end
#       end
#     end
#   end
# end
Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 1
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 5.minutes
Delayed::Worker.read_ahead = 10
Delayed::Worker.default_queue_name = "default"
Delayed::Worker.delay_jobs = true #  !Rails.env.test?
Delayed::Worker.raise_signal_exceptions = :term
Delayed::Worker.logger = Logger.new(File.join(Rails.root, "log", "delayed_job.log"))
