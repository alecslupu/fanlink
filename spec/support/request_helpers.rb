# frozen_string_literal: true

module RequestHelpers
  #   def delete(*args)
  #     super *add_accept_header(args)
  #   end
  #
  #   def get(*args)
  #     super *add_accept_header(args)
  #   end
  #
  #   def patch(*args)
  #     super *add_accept_header(args)
  #   end
  #
  #   def post(*args)
  #     super *add_accept_header(args)
  #   end
  #
  #   def put(*args)
  #     super *add_accept_header(args)
  #   end
  #
  # private
  #
  #   def add_accept_header(args)
  #     vmatch = /V([0-9]).*\:\:/.match(self.class.name)
  #     v = vmatch.nil? ? 3 : vmatch[1]
  #     request.add_header "Accept", "application/vnd.api.v#{v}+json"
  #     add_json_format(args)
  #   end
  #
  #   def add_json_format(args)
  #     new_args = args[0 .. args.length]
  #     if new_args.last.is_a?(Hash)
  #       new_args[-1] = { format: :json }.merge(new_args.last)
  #     else
  #       new_args[new_args.length] = { format: :json }
  #     end
  #     new_args
  #   end
end
