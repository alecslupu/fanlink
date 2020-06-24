# frozen_string_literal: true

module PermissionMatrix
  extend ActiveSupport::Concern

  included do
    include FlagShihTzu
    %w[event merchandise user badge reward quest beacon reporting interest root portal_notification marketing_notification automated_notification].each do |field|
      has_flags 1 => "#{field}_read".to_sym,
                2 => "#{field}_update".to_sym,
                3 => "#{field}_delete".to_sym,
                4 => "#{field}_export".to_sym,
                5 => "#{field}_history".to_sym,
                column: field
    end

    has_flags 1 => :post_read,
              2 => :post_update,
              3 => :post_delete,
              4 => :post_export,
              5 => :post_history,
              6 => :post_hide,
              7 => :post_ignore,
              column: 'post'

    has_flags 1 => :admin_read,
              2 => :admin_update,
              3 => :admin_delete,
              4 => :admin_history,
              5 => :admin_export,
              column: 'admin'

    has_flags 1 => :trivia_read,
              2 => :trivia_update,
              3 => :trivia_delete,
              4 => :trivia_export,
              5 => :trivia_history,
              6 => :trivia_generate_game_action,
              column: 'trivia'

    has_flags 1 => :chat_read,
              2 => :chat_update,
              3 => :chat_delete,
              4 => :chat_export,
              5 => :chat_history,
              6 => :chat_hide,
              7 => :chat_ignore,
              column: 'chat'

    has_flags 1 => :courseware_read,
              2 => :courseware_update,
              3 => :courseware_delete,
              4 => :courseware_export,
              5 => :courseware_history,
              6 => :courseware_forget,
              7 => :courseware_reset,
              column: 'courseware'

    def summarize
      perms = {}
      self.flag_columns.each do |column|
        self.as_flag_collection(column).collect do |o|
          perms[o.first] = o.second
        end
      end
      perms
    end
  end
end
