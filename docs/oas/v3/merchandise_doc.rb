class Api::V3::MerchandiseDoc < Api::V3::BaseDoc
  doc_tag name: "Merchandise", desc: "Product Merchandise"
  route_base "api/v3/merchandise"

  components do
    resp MerchandiseArray: ["HTTP/1.1 200 Ok", :json, data: {
      merchandise: [
        merchandise: :MerchandiseJson
      ]
    }]
    resp MerchandiseObject: ["HTTP/1.1 200 Ok", :json, data: {
      merchandise: :MerchandiseJson
    }]

    body! :MerchandiseForm, :form, data: {
      merchandise!: {
        name!: { type: String, desc: "Name of the item." },
        description!: { type: String, desc: "Description of the item." },
        price: { type: Integer, desc: "Price of the item." },
        picture: { type: File, desc: "Image associated with the item" },
        available!: { type: Boolean, desc: "Is the item currently available", dft: true },
        priority!: { type: Integer, desc: "Where the item resides in the list. A number greater than 0 means the item will show up sooner in the list.", dft: 0 },
        purchase_url: { type: String, desc: "Where a user can purchase this item." }
      }
    }
    body! :MerchandiseUpdateForm, :form, data: {
      merchandise!: {
        name: { type: String, desc: "Name of the item." },
        description: { type: String, desc: "Description of the item." },
        price: { type: Integer, desc: "Price of the item." },
        picture: { type: File, desc: "Image associated with the item" },
        available: { type: Boolean, desc: "Is the item currently available", dft: true },
        priority: { type: Integer, desc: "Where the item resides in the list. A number greater than 0 means the item will show up sooner in the list.", dft: 0 },
        purchase_url: { type: String, desc: "Where a user can purchase this item." }
      }
    }
  end

  api :index, "Get available merchandise." do
    need_auth :SessionCookie
    desc "This gets a list of merchandise, in priority order."
    query :page, Integer, desc: "page, greater than 1", range: { ge: 1 }, dft: 1
    query :per_page, Integer, desc: "data count per page",  range: { ge: 1 }, dft: 25
    response_ref 200 => :MerchandiseArray
  end

  api :create, "Create a merchandise item" do
    need_auth :SessionCookie
    desc "Create a merchandise item for the user's current product"
    body_ref :MerchandiseForm
    response_ref 200 => :MerchandiseObject
  end

  api :show, "Get a single piece of merchandise." do
    need_auth :SessionCookie
    desc "This gets a single piece of merchandise for a merchandise id."
    path! :id, Integer, desc: "The id of the merchandise you are wanting to retrieve."
    response "404", "Not Found. The database doesn't contain a record for that id."
    response_ref 200 => :MerchandiseObject
  end

  api :destroy, "Delete a merchandise item." do
    desc "Soft deletes a merchandise item."
    need_auth :SessionCookie
    path! :id, Integer, desc: "The id of the merchandise you are wanting to retrieve."
    response_ref 200 => :OK
  end
end
