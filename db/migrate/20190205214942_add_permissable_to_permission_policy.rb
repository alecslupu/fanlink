class AddPermissableToPermissionPolicy < ActiveRecord::Migration[5.1]
  def change
    add_reference :permission_policies, :permissable, polymorphic: true, index: { name: "permissable_policies" }
  end
end
