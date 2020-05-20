# frozen_string_literal: true

require "spec_helper"

RSpec.describe ApplicationPolicy, type: :policy do

  permission_list = {
    index: false,
    show: false,
    create: false,
    new: false,
    update: false,
    edit: false,
    destroy: false,
    export: false,
    history: false,
    show_in_app: false,
    dashboard: false,
    # select_product_dashboard: false,
    select_product: false
  }


  describe "defined policies" do
    subject { described_class.new(build(:super_admin), nil) }

    permission_list.each do |policy, value|
      it { is_expected.to respond_to("#{policy}?".to_sym) }
    end
  end
end
