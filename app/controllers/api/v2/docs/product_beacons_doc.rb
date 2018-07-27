class Api::V2::Docs::ActivtyTypesDoc < Api::V2::Docs::BaseDoc
  doc_tag name: "ProductBeacons", desc: "Beacons assigned to a product"
  route_base "api/v2/product_beacons"
  components do
    resp ProductBeaconObject: ["HTTP/1.1 200 Ok", :json, data: {
      beacon: :ProductBeaconJson
    }]

    resp ProductBeaconArray: ["HTTP/1.1 200 Ok", :json, data: {
      beacons: [
        beacon: :ProductBeaconJson
      ]
    }]

    body! :BeaconCreateForm, :form, data: {
      product_beacon!: {
        beacon_pid!: { type: String, desc: "The manufacturer's id of the beacon" },
        uuid!: { type: String, desc: "The UUID of the beacon." },
        lower!: { type: String, desc: "Lower value." },
        upper!: { type: String, desc: "Upper value." },
        attached_to: { type: Integer, nullable: true, desc: "The activity the beacon is attached to. Can be null." }
      }
    }

    body! :BeaconUpdateForm, :form, data: {
      product_beacon!: {
        beacon_pid: { type: String, desc: "The manufacturer's id of the beacon" },
        uuid: { type: String, desc: "The UUID of the beacon." },
        lower: { type: String, desc: "Lower value." },
        upper: { type: String, desc: "Upper value." },
        attached_to: { type: Integer, nullable: true, desc: "The activity the beacon is attached to. Can be null." }
      }
    }
  end

  api :index, "Get Product Beacons" do
    desc "Get beacons for a product."
    response_ref 200 => :ProductBeaconArray
  end

  api :create, "Create a beacon" do
    desc "Add a beacon to the current user's product."
    body_ref :BeaconCreateForm
    response_ref 200 => :ProductBeaconObject
  end

  api :list, "Get all beacons" do
    desc "This returns all beacons, regardless of deleted status."
    response_ref 200 => :ProductBeaconArray
  end

  api :show, "Get Product Beacon" do
    desc "Returns the product beacon for the passed in ID."
    response_ref 200 => :ProductBeaconObject
  end

  api :update, "Update a beacon" do
    desc "Updates a product beacon."
    body_ref :BeaconUpdateForm
    response_ref 200 => :ProductBeaconObject
  end

  api :destroy, "Destroy Product Beacon" do
    desc "Soft deletes a product beacon"
    response_ref 200 => :OK
  end
end
