class ActionTypeIndex < Chewy::Index
  define_type ActionType.includes(:badges, :rewards) do
    field :name
    field :internal_name
    field :active
  end
end
