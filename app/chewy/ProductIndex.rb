class ProductIndex < Chewy::Index
  define_type Product.includes(:people, :quests, :product_beacons, :events, :levels) do
    field :name
    field :internal_name
  end
end
