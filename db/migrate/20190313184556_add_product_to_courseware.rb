class AddProductToCourseware < ActiveRecord::Migration[5.1]
  def change
    #,,, to not break staging data
    product = Product.find_by(internal_name: "caned")
    if product.nil?
      add_column :certificates, :product_id, :integer, null: false
      add_column :certcourses, :product_id, :integer, null: false
      add_column :certificate_certcourses, :product_id, :integer, null: false
      add_column :certcourse_pages, :product_id, :integer, null: false
      add_column :answers, :product_id, :integer, null: false
      add_column :quiz_pages, :product_id, :integer, null: false
      add_column :image_pages, :product_id, :integer, null: false
      add_column :video_pages, :product_id, :integer, null: false
    else
      add_column :certificates, :product_id, :integer, default: product.id, null: false
      add_column :certcourses, :product_id, :integer, default: product.id, null: false
      add_column :certificate_certcourses, :product_id, :integer, default: product.id, null: false
      add_column :certcourse_pages, :product_id, :integer, default: product.id, null: false
      add_column :answers, :product_id, :integer, default: product.id, null: false
      add_column :quiz_pages, :product_id, :integer, default: product.id, null: false
      add_column :image_pages, :product_id, :integer, default: product.id, null: false
      add_column :video_pages, :product_id, :integer, default: product.id, null: false

      change_column_default :certificates, :product_id, nil
      change_column_default :certcourses, :product_id, nil
      change_column_default :certificate_certcourses, :product_id, nil
      change_column_default :certcourse_pages, :product_id, nil
      change_column_default :answers, :product_id, nil
      change_column_default :quiz_pages, :product_id, nil
      change_column_default :image_pages, :product_id, nil
      change_column_default :video_pages, :product_id, nil
    end

    add_foreign_key :certificates, :products, name: "fk_certificates_products", on_delete: :cascade
    add_index :certificates, %i[ product_id ], name: "idx_certificates_product"

    add_foreign_key :certcourses, :products, name: "fk_certcourses_products", on_delete: :cascade
    add_index :certcourses, %i[ product_id ], name: "idx_certcourses_product"

    add_foreign_key :certificate_certcourses, :products, name: "fk_certificate_certcourses_products", on_delete: :cascade
    add_index :certificate_certcourses, %i[ product_id ], name: "idx_certificate_certcourses_product"

    add_foreign_key :certcourse_pages, :products, name: "fk_certcourse_pages_products", on_delete: :cascade
    add_index :certcourse_pages, %i[ product_id ], name: "idx_certcourse_pages_product"

    add_foreign_key :answers, :products, name: "fk_answers_products", on_delete: :cascade
    add_index :answers, %i[ product_id ], name: "idx_answers_product"

    add_foreign_key :quiz_pages, :products, name: "fk_quiz_products", on_delete: :cascade
    add_index :quiz_pages, %i[ product_id ], name: "idx_quiz_pages_product"

    add_foreign_key :image_pages, :products, name: "fk_image_products", on_delete: :cascade
    add_index :image_pages, %i[ product_id ], name: "idx_image_pages_product"

    add_foreign_key :video_pages, :products, name: "fk_video_products", on_delete: :cascade
    add_index :video_pages, %i[ product_id ], name: "idx_video_pages_product"
  end
end
