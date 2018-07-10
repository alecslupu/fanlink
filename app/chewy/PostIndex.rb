class PostIndex < Chewy::Index
  define_type Post.includes(:tags) do
  end
end
