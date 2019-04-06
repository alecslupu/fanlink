class Api::V4::Trivia::PackagesController < ApiController
  def index
    @packages = paginate(::Trivia::Package.all)
    return_the @packages, handler: 'jb'
  end
end
