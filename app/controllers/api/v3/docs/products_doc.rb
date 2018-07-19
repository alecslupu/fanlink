class Api::V3::Docs::ActivtyTypesDoc < Api::V3::Docs::BaseDoc
doc_tag name: 'Products', desc: "Products"
  route_base 'api/v3/products'
  components do
    resp :ProductObject  => ['HTTP/1.1 200 Ok', :json, data:{
      :product => :ProductJson
    }]

    resp :ProductArray  => ['HTTP/1.1 200 Ok', :json, data:{
      :products => [
        :product => :ProductJson
      ]
    }]

    # resp :ProductSelect => ['HTTP/1.1 200 Ok', :json, data: {
    #   :products => [
    #     :name => { type: String },
    #     :internal_name => { type: String },
    #     :id => { type: Integer }
    #   ]
    # }]

    body! :ProductCreateForm, :form, data: {
      :product! => {
        :name! => { type: String, desc: 'Product display name.' },
        :internal_name! => { type: String, desc: 'Product internal name.' },
        :enabled => { type: Boolean, desc: 'Whether or not the product is enabled.', dft: false }
      }
    }

    body! :ProductUpdateForm, :form, data: {
      :product! => {
        :name => { type: String, desc: 'Product display name.' },
        :internal_name => { type: String, desc: 'Product internal name.' },
        :enabled => { type: Boolean, desc: 'Whether or not the product is enabled.', dft: false }
      }
    }
  end

  api :index, 'Get Products' do
    need_auth :SessionCookie
    desc 'Get all products (Super Admin Only)'
    response_ref 200 => :ProductArray
  end

  # api :select, 'Product Select list' do
  #   need_auth :SessionCookie
  #   desc 'Returns a select list for products (Super Admin Only)'
  #   response_ref 200 => :ProductSelect
  # end

  api :create, 'Create Product' do
    need_auth :SessionCookie
    desc 'Create a product (Super Admin Only)'
    body_ref :ProductCreateForm
    response_ref 200 => :ProductObject
  end

  api :show, 'Get Product' do
    need_auth :SessionCookie
    desc 'Get a product for provided ID. (Super Admin Only)'
    response_ref 200 => :ProductObject
  end

  api :update, 'Update Product' do
    need_auth :SessionCookie
    desc 'Update a product (Super Admin Only)'
    body_ref :ProductUpdateForm
    response_ref 200 => :ProductObject
  end
end
