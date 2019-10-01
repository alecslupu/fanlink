namespace :load_testing do
  desc "load a bunch of users for load testing"
  task load_users: :environment do
    abort("do NOT run this in production") if Rails.env.production?
    prod = Product.find_by(internal_name: "test")
    abort("No test product found") if prod.nil?
    starting = (ARGV.count < 2) ? 0 : ARGV[1].to_i
    precount = Person.count
    1000.times do |n|
      num = starting + n
      unless Person.where(username: "user_#{num}").exists?
        Person.create(name: "Seed User#{num}", username: "user_#{num}", product_id: prod.id, email: "user#{num}@example.com", password: "password", role: :normal)
      end
    end
    puts "#{Person.count - precount} new users created"
  end
end
