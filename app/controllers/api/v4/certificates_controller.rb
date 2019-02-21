class Api::V4::CertificatesController < ApiController
  def index
    @certificates = paginate Certificate.all
    #return_the @certificates, handler: 'jb'
    render json: {"certificates": [{"id":1,"order":1,"long_name":"Certificate Dummy Long Name","short_name":"Short name Dummy",
      "description":"Dummy Test","color_hex":"#FF00FF","chat_room_id":1493, "sku_android":"", "sku_ios":"", "is_free":false,"is_completed":true,"is_purchased":true,"certificate_image_url":""}]}
  end

  def show
    @certificate = Certificate.find(params[:id])
    #return_the @certificate, handler: 'jb'
    render json: {message: "This will be the Certificate show page"}
  end
end
