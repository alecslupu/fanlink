class CreateCoursewareWishlistWishlists < ActiveRecord::Migration[5.1]
  def change
    create_table :courseware_wishlist_wishlists do |t|
      t.references :person, foreign_key: true
      t.references :certificate, foreign_key: true

      t.timestamps
    end
  end
end
