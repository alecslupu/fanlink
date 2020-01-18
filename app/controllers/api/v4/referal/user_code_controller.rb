class Api::V4::Referal::UserCodeController < ApiController

  def index
    @referal_code = current_user.find_or_create_referal_code
    return_the @referal_code, handler: :jb
  end

end
