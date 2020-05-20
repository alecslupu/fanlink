# frozen_string_literal: true
class Api::V4::ProductBeaconsController < Api::V3::ProductBeaconsController
  def index
    @product_beacons = paginate(ProductBeacon.where.not(deleted: true).order(created_at: :desc))
    return_the @product_beacons, handler: tpl_handler
  end

  def list
    @product_beacons = paginate(ProductBeacon.where("product_id =?", ActsAsTenant.current_tenant.id))
    return_the @product_beacons, handler: tpl_handler
  end

  def show
    @product_beacon = ProductBeacon.where.not(deleted: true).for_id_or_pid(params[:id])
    return_the @product_beacon, handler: tpl_handler
  end

  def create
    @product_beacon = ProductBeacon.create(beacon_params)
    if @product_beacon.valid?
      return_the @product_beacon, handler: tpl_handler, using: :show
    else
      render_422 @product_beacon.errors
    end
  end

  def update
    if params.has_key?(:product_beacon)
      if @product_beacon.update(beacon_update_params)
        return_the @product_beacon, handler: tpl_handler, using: :show
      else
        render_422 @product_beacon.errors
      end
    else
      render_422(_("Update failed. Missing product_beacon object."))
    end
  end

  protected

    def tpl_handler
      :jb
    end
end
