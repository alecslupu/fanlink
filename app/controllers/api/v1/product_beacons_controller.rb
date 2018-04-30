class Api::V1::ProductBeaconsController < ApiController
    include Rails::Pagination

    before_action :admin_only
    
    def index
        @beacons = paginate
        return_the @beacons
    end

    def show
        @beacon = ProductBeacons.find(params[:id]);
        return_the @beacon
    end

    def create
        @beacon = ProductBeacon.create(beacon_params)
        return_the @quest
    end

    def destroy
        beacon = ProductBeacon.find(params[:id])
        if current_user.some_admin
          beacon.deleted = true
          head :ok
        else
          render_not_found
        end    
    end

private

    def beacon_params
        params.require(:product_beacon).permit(:beacon_pid, :attached_to)
    end    
end