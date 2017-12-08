# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Product.count == 0
  Product.create(name: "Admin", subdomain: "admin")
  unless Rails.env.production?
    Product.create(name: "Test Product", subdomain: "test")
    Product.create(name: "Test Product2", subdomain: "test2")
  end
end

if Person.count == 0
  unless Rails.env.production?
    Person.create(product_id: Product.find_by(subdomain: "admin").id, email: "admin@example.com", password: "flink_admin")
  end
end
