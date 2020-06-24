# frozen_string_literal: true

module FloadUp
  extend ActiveSupport::Concern

  module ClassMethods
    #
    # Automatically load and access-check an instance of `klass` from the
    # database. We will check that the `current_user` can work with the
    # object by calling `allows_#{params[:action]}_from? current_user`.
    #
    # The `:from` option tells us which key in `params` contains the
    # object's `id`. The `:into` option tells us the name of the instance
    # variable to set. The `:using` option tells us the name of the class
    # method to use to lookup the model instance.
    #
    # We have sensible defaults for all the options so these calls do the
    # same thing:
    #
    #     load_up_the OneCentStamp, :from => :id, :using => :find, :into => :@one_cent_stamp
    #     load_up_the OneCentStamp
    #
    # Sometimes your controller method names don't match up with your
    # access control methods. When this happens, you can use `:alias` to
    # provide a mapping table; for example:
    #
    #     :alias => { :pancakes => :show }
    #
    # would tell us to use `allows_show_from?(current_user)` to access check
    # our object when the `pancakes` controller was called. You can also alias
    # a controller method to `true` or `false` (with the obvious results) or
    # something that responds to `call` (such as a proc or lambda); callable
    # aliases are called with the object, the current user, and property as
    # arguments (in that order).
    #
    # @param [Class] klass
    #   The class to load from the database.
    # @parma [options] Hash
    #   The options, see above.
    #
    def load_up_the(klass, options = nil)
      options = {
        from: :id,
        using: :find_by_id,
        into: "@#{klass.name.underscore}",
        alias: {},
        except: []
      }.merge(options.to_h)

      id       = options[:from ]
      find     = options[:using]
      obj_name = options[:into ]
      actions  = extract_actions_from(options)

      before_action except: options[:except] do
        if params.has_key?(id)
          obj = klass.send(find, params[id])
          if !obj
            render_not_found
          elsif obj
            instance_variable_set(obj_name, obj)
          end
        end
      end
    end

    private

    def extract_actions_from(options)
      actions = (options[:alias] || {}).with_indifferent_access
      actions.default_proc = ->(_, k) { k }
      actions
    end
  end
end
