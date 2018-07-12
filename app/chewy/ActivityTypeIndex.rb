class ActivityTypeIndex < Chewy::Index
  define_type ActivityType do
    field :atype
    field :value, type: 'object'
    field :deleted, type: 'boolean'
  end
end
