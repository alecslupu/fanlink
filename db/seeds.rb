# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Product.count == 0
  Product.create(name: "Admin", internal_name: "admin")
  unless Rails.env.production?
    Product.create(name: "Test Product", internal_name: "test")
    Product.create(name: "Test Product2", internal_name: "test2")
  end
end

if Person.count == 0
  unless Rails.env.production?
    Person.create(name: "Admin User", username: "admin", product_id: Product.find_by(internal_name: "admin").id, email: "admin@example.com",
                  password: "flink_admin")
  end
end
