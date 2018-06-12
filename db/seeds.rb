# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Product.count == 0
  Product.create(name: "Admin", internal_name: "admin", can_have_supers: true, enabled: true)
  unless Rails.env.production?
    Product.create(name: "Test Product", internal_name: "test")
    Product.create(name: "Test Product2", internal_name: "test2")
  end
end

if Person.count == 0
  unless Rails.env.production?
    Person.create(name: "Admin User", username: "admin", product_id: Product.find_by(internal_name: "admin").id, email: "admin@example.com",
                  password: "flink_admin", role: :super_admin)
    Person.create(name: "Some User", username: "some_user", product_id: Product.find_by(internal_name: "test").id, email: "somebody@example.com", password: "password")
  end
end

if Room.count < 10
  unless Rails.env.production?
    prod = Product.find_by(internal_name: "test").try(:id)
    u = Person.find_by(name: "Admin User").try(:id)
    if prod && u
      1.upto 10 do |n|
        unless (Room.where(id: n)).exists?
          Room.create(name: "Public room #{n}", created_by_id: u, public: true, product_id: prod, status: :active)
        end
      end
    end
  end
end

if ActionType.count == 0
  unless Rails.env.production?
    ActionType.create(name: "Some Cool Act", internal_name: "some_cool_act")
  end
end

if Category.count == 0
  unless Rails.env.production?
    Product.all.each do |p|
      Category.create(name: "Uncategorized", color: "#ffffff", role: :normal, product_id: p.id)
    end
  end
end
