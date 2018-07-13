class Api::V2::Docs::MerchandiseDoc < Api::V2::Docs::BaseDoc
  doc_tag name: 'Merchandise', desc: "Product Merchandise"
  route_base 'api/v2/merchandise'

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
    need_auth :SessionCookie
    desc ' This gets a list of merchandise, in priority order.'
    query :page, Integer, desc: 'page, greater than 1', range: { ge: 1 }, dft: 1
    query :per_page, Integer, desc: 'data count per page',  range: { ge: 1 }, dft: 25
    response_ref 200 => :MerchandiseArray
  end

  # api :create, '' do

  # end

  api :show, 'Get a single piece of merchandise.' do
    need_auth :SessionCookie
    desc 'This gets a single piece of merchandise for a merchandise id.'
    path! :id, Integer, desc: 'id'
    response '404', 'Not Found. The database doesn\'t contain a record for that id.'
    response_ref 200 => :MerchandiseObject
  end

  # api :destroy, '' do
  #   response_ref 200 => :Delete
  # end
end
