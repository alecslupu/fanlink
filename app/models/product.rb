# == Schema Information
#
# Table name: products
#
#  id                   :bigint(8)        not null, primary key
#  name                 :string           not null
#  internal_name        :string           not null
#  enabled              :boolean          default(FALSE), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  can_have_supers      :boolean          default(FALSE), not null
#  age_requirement      :integer          default(0)
#  logo_file_name       :string
#  logo_content_type    :string
#  logo_file_size       :integer
#  logo_updated_at      :datetime
#  color_primary        :string           default("4B73D7")
#  color_primary_text   :string           default("FFFFFF")
#  color_secondary      :string           default("CDE5FF")
#  color_secondary_text :string           default("000000")
#  color_tertiary       :string           default("FFFFFF")
#  color_tertiary_text  :string           default("000000")
#  color_accent         :string           default("FFF537")
#  color_accent_text    :string           default("FFF537")
#  color_title_text     :string           default("FFF537")
#  color_accessory      :string           default("000000")
#  navigation_bar_style :integer          default(1)
#  status_bar_style     :integer          default(1)
#  toolbar_style        :integer          default(1)
#  features             :integer          default(0), not null
#  contact_email        :string
#  privacy_url          :text
#  terms_url            :text
#  android_url          :text
#  ios_url              :text
#

class Product < ApplicationRecord
  include AttachmentSupport
  has_paper_trail

  has_image_called :logo

  validates :name, length: { in: 3..60, message: _("Name must be between 3 and 60 characters.") }, uniqueness: { message: _("Product %{product_name} already exists.") % { product_name: name } }

  validates :internal_name, format: { with: /\A[a-zA-Z0-9_]+\z/, allow_blank: true, message: _("Internal name can only contain letters, numbers and underscores.") },
            presence: { message: _("Internal name is required.") },
            length: { in: 3..30, message: _("Internal name must be between 3 and 63 characters."), allow_blank: true },
            uniqueness: { message: _("Internal name already exists.") }

  has_many :people, dependent: :restrict_with_error
  has_many :quests, dependent: :restrict_with_error
  has_many :product_beacons, dependent: :restrict_with_error
  has_many :events, dependent: :restrict_with_error
  has_many :levels, dependent: :restrict_with_error
  has_many :polls, dependent: :restrict_with_error

  has_many :trivia_games, class_name: "Trivia::Game", dependent: :restrict_with_error

  scope :enabled, -> { where(enabled: true) }

  def people_count
    people.count
  end

  def to_s
    internal_name
  end
end
