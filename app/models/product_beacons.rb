class ProductBeacon < ApplicationRecord
    belongs_to :product


    def self.for_id_or_pid(id)
        query = id.include('-') ? {beacon_pid: id} : {id: id}
        Product_Beacon.find_by(query)
    end

end