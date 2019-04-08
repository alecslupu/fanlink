class Api::V5::ProductBeaconsController < Api::V4::ProductBeaconsController
  def index
    @product_beacons = paginate(ProductBeacon.where.not(deleted: true).order(created_at: :desc))
    return_the @product_beacons, handler: tpl_handler
  end

  def show
    @product_beacon = ProductBeacon.where.not(deleted: true).for_id_or_pid(params[:id])
    return_the @product_beacon, handler: tpl_handler
  end
end
