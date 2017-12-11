class Person < ApplicationRecord
  authenticates_with_sorcery!

  acts_as_tenant(:product)

  belongs_to :product

  validates :email, email: true

  validates :name, presence: { message: "is missing." }

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
end
