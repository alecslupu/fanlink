# == Schema Information
#
# Table name: roles
#
#  id                     :bigint(8)        not null, primary key
#  name                   :string           not null
#  internal_name          :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  post                   :integer          default(0), not null
#  chat                   :integer          default(0), not null
#  event                  :integer          default(0), not null
#  merchandise            :integer          default(0), not null
#  badge                  :integer          default(0), not null
#  reward                 :integer          default(0), not null
#  quest                  :integer          default(0), not null
#  beacon                 :integer          default(0), not null
#  reporting              :integer          default(0), not null
#  interest               :integer          default(0), not null
#  courseware             :integer          default(0), not null
#  trivia                 :integer          default(0), not null
#  admin                  :integer          default(0), not null
#  root                   :integer          default(0), not null
#  user                   :integer          default(0), not null
#  portal_notification    :integer          default(0), not null
#  marketing_notification :integer          default(0), not null
#  automated_notification :integer          default(0), not null
#

class Role < ApplicationRecord
  include PermissionMatrix

  has_many :people, inverse_of: :role
  validates :internal_name, uniqueness: true

  scope :clients, -> { where(internal_name: 'client') }
  scope :normals, -> { where(internal_name: 'normal') }
  has_paper_trail

  def to_s
    internal_name
  end

end
