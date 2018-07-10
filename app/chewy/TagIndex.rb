class TagIndex < Chewy::Index
  define_type Tag.includes(:posts) do
    field :name
    field :deleted, type: 'boolean'
  end
end
