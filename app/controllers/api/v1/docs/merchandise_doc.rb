class Api::V1::Docs::MerchandiseDoc < Api::V1::Docs::BaseDoc
  doc_tag name: 'Merchandise', desc: "Product Merchandise"
  route_base 'api/v1/merchandise'

  components do
    resp :MerchandiseArray => ['HTTP/1.1 200 Ok', :json, data:{
      :merchandise => [
        :merchandise => :Merchandise
      ]
    }]
    resp :MerchandiseObject => ['HTTP/1.1 200 Ok', :json, data:{
      :merchandise => :Merchandise
    }]
  end

  api :index, 'Get available merchandise.' do
    desc ' This gets a list of merchandise, in priority order.'
    response_ref 200 => :MerchandiseArray
  end

  # api :create, '' do

  # end

  api :show, 'Get a single piece of merchandise.' do
    desc 'This gets a single piece of merchandise for a merchandise id.'
    response_ref 200 => :MerchandiseObject
  end

  # api :destroy, '' do
  #   response_ref 200 => :Delete
  # end
end
