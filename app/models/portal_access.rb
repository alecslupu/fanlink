# == Schema Information
#
# Table name: portal_accesses
#
#  id          :bigint(8)        not null, primary key
#  person_id   :integer          not null
#  post        :integer          default(0), not null
#  chat        :integer          default(0), not null
#  event       :integer          default(0), not null
#  merchandise :integer          default(0), not null
#  user        :integer          default(0), not null
#  badge       :integer          default(0), not null
#  reward      :integer          default(0), not null
#  quest       :integer          default(0), not null
#  beacon      :integer          default(0), not null
#  reporting   :integer          default(0), not null
#  interest    :integer          default(0), not null
#  courseware  :integer          default(0), not null
#  trivia      :integer          default(0), not null
#

class PortalAccess < ApplicationRecord
  include FlagShihTzu

  scope :for_product, -> (product) { joins(:person).where(people: { product_id: product.id }) }
  belongs_to :person

  %w(post event merchandise user badge reward quest beacon reporting interest trivia).each do |field|
    has_flags 1 => "#{field}_read".to_sym,
              2 => "#{field}_update".to_sym,
              3 => "#{field}_delete".to_sym,
              4 => "#{field}_export".to_sym,
              5 => "#{field}_history".to_sym,
              column: field
  end


  has_flags 1 => :chat_read,
            2 => :chat_update,
            3 => :chat_delete,
            4 => :chat_export,
            5 => :chat_history,
            6 => :chat_hide,
            7 => :chat_ignore,
            column: :chat

  has_flags 1 => :courseware_read,
            2 => :courseware_update,
            3 => :courseware_delete,
            4 => :courseware_export,
            5 => :courseware_history,
            6 => :courseware_forget,
            7 => :courseware_reset,
            column: :courseware

  def summarize
    perms = {}
    self.flag_columns.each do |column|
      self.as_flag_collection(column, :"#{column}_read", :"#{column}_update", :"#{column}_delete").collect do |o|
        perms[o.first] = o.second
      end
    end
    perms
  end
end
