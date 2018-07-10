class CategoryIndex < Chewy::Index
  define_type Category.includes(:posts) do
  end
end
