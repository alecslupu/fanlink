class Api::V2::Docs::CategoriesDoc < Api::V2::Docs::BaseDoc
  doc_tag name: "Categories", desc: "Categories"
  route_base "api/v2/categories"
  components do
    resp CategoryObject: ["HTTP/1.1 200 Ok", :json, data: {
      category: :CategoryJson
    }]
    resp CategoryArray: ["HTTP/1.1 200 Ok", :json, data: {
      categories: [
        category: :CategoryJson
      ]
    }]
    # TODO: Add enums to enumerable fields
    body! :CategoryForm, :form, data: {
      category!: {
        name!: { type: String, desc: "Category name." },
        color: { type: String, desc: "The color hex code for the category." },
        role!: { type: String, desc: "The role the category is allowed to be used by. Supports normal, product, staff, admin, super_admin." }
      }
    }
    body! :CategoryUpdateForm, :form, data: {
      category!: {
        name: { type: String, desc: "Category name." },
        color: { type: String, desc: "The color hex code for the category." },
        role: { type: String, desc: "The role the category is allowed to be used by. Supports normal, product, staff, admin, super_admin." }
      }
    }
  end

  api :index, "Get Categories for Product" do
    need_auth :SessionCookie
    desc "Returns categories for product based on current users role."
    query :product, String, desc: "Internal name of product to get categories for"
    response_ref 200 => :CategoryArray
  end

  api :create, "Create a category" do
    need_auth :SessionCookie
    desc "Creates a category for current user's associated product."
    body_ref :CategoryJson
    response_ref 200 => :CategoryObject
  end

  # api :list, '' do
  #   need_auth :SessionCookie
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  api :show, "Get a category" do
    need_auth :SessionCookie
    desc "Gets a category by ID."
    response_ref 200 => :CategoryObject
  end

  api :update, "Update a category" do
    need_auth :SessionCookie
    desc "Updates a category with the passed in ID."
    body_ref :CategoryUpdateForm
    response_ref 200 => :CategoryObject
  end

  # api :destroy, '' do
  #   need_auth :SessionCookie
  #   desc ''
  #   response_ref 200 => :OK
  # end
end
