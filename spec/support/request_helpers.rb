module RequestHelpers
  def default_request_format(args)
    new_args = args[0 .. args.length]
    if new_args.last.is_a?(Hash)
      new_args[-1] = { format: :json }.merge(new_args.last)
    else
      new_args[new_args.length] = { format: :json }
    end
    new_args
  end

  def delete(*args)
    super *add_accept_header(args)
  end

  def get(*args)
    super *add_accept_header(args)
  end

  def post(*args)
    super *add_accept_header(args)
  end


private

  def add_accept_header(args)
    acc = { "ACCEPT" => "application/vnd.api.v1+json" }
    if args.size == 1
      args << { headers: acc }
    elsif args[1][:headers]
      args[1][:headers].merge(acc)
    else
      args[1][:headers] = acc
    end
    args
  end
end
