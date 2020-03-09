
topics = [
  { name: "Laws and Regulations", status: :published},
  { name: "Cannabis Freedom Fighters", status: :published},
  { name: "Terpenoids and Cannabinoids", status: :published},
  { name: "Definitions", status: :published},
  { name: "Lifestyle", status: :published},
  { name: "Politics", status: :published},
  { name: "Cannabis Culture", status: :published},
  { name: "Methods of Consumption", status: :published},
  { name: "Celebrities in Cannabis", status: :published},
  { name: "Growing Cannabis", status: :published},
  { name: "History", status: :published},
  { name: "Cannabis Economics", status: :published},
  { name: "Science of Cannabis", status: :published},
  { name: "Strains", status: :published},
  { name: "Hemp and Hemp Products", status: :published},
  { name: "Facts and Myths", status: :published},
  { name: "Legal Cannabis Worldwide", status: :published},
  { name: "Paraphernalia", status: :published},
  { name: "Cannabis Terms and Definitions", status: :published},
  { name: "Medical Benefits", status: :published}
]


products = Product.where(internal_name: %w(caned cantrivia))

products.each do |product|
  ActsAsTenant.with_tenant(product) do
    topics.each do |topic|
      t = Trivia::Topic.where(name: topic[:name]).first_or_initialize
      t.published!
    end


  end
end
