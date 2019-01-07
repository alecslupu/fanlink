class Api::V5::SessionController < Api::V4::SessionController
  def index
    if @person = current_user
      if @person.terminated
        return head :unauthorized
      else
        return_the @person, handler: 'jb'
      end
    else
      render_not_found
    end
  end
end
