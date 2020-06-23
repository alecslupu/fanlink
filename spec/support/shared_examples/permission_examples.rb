# frozen_string_literal: true

RSpec.shared_examples 'enforces the permissions' do |klass, module_name|

  let(:master_class) { klass.new }
  subject { described_class.new(Person.new, master_class) }

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
    select_product: false
  }

  describe 'defined policies' do
    permission_list.each do |policy, value|
      it { is_expected.to respond_to("#{policy}?".to_sym) }
    end
  end
  context 'logged in user with no permission' do
    describe 'permissions' do
      permission_list.each do |policy, value|
        it { is_expected.to forbid_action(policy) }
      end
    end
    describe 'protected methods' do
      it { expect(subject.send(:module_name)).to eq(module_name) }
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, 'bogous')).to eq(false) }
      it { expect(subject.send(:has_permission?, 'index')).to eq(false) }
    end
  end
  context 'logged in admin with no permission' do
    subject { described_class.new(Person.new(role: build(:role_admin)), master_class) }

    describe 'permissions' do
      permission_list.each do |policy, value|
        it { is_expected.to forbid_action(policy) }
      end
    end
    describe 'protected methods' do
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, 'bogous')).to eq(false) }
      it { expect(subject.send(:has_permission?, 'index')).to eq(false) }
    end
  end

end

RSpec.shared_examples 'enforces the history permission' do |klass, module_name|

  let(:master_class) { klass.new }
  subject { described_class.new(Person.new, master_class) }
  context 'logged in admin with history permission' do
    permission_list = {
      index: false,
      show: false,
      create: false,
      new: false,
      update: false,
      edit: false,
      destroy: false,
      export: false,
      history: true,
      show_in_app: false,
      select_product: false
    }

    before :each do
      allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new("#{module_name}_history": true))
    end
    describe 'permissions' do
      permission_list.each do |policy, value|
        if value
          it { is_expected.to permit_action(policy) }
        else
          it { is_expected.to forbid_action(policy) }
        end
      end
    end
    describe 'protected methods' do
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, 'bogous')).to eq(false) }
      it { expect(subject.send(:has_permission?, 'index')).to eq(false) }
    end
  end
end

RSpec.shared_examples 'enforces the export permission' do |klass, module_name|

  let(:master_class) { klass.new }
  subject { described_class.new(Person.new, master_class) }
  context 'logged in admin with export permission' do
    permission_list = {
      index: false,
      show: false,
      create: false,
      new: false,
      update: false,
      edit: false,
      destroy: false,
      export: true,
      history: false,
      show_in_app: false,
      select_product: false
    }

    describe 'permissions' do
      before :each do
        allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new("#{module_name}_export": true))
      end
      permission_list.each do |policy, value|
        if value
          it { is_expected.to permit_action(policy) }
        else
          it { is_expected.to forbid_action(policy) }
        end
      end
    end
    describe 'protected methods' do
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, 'bogous')).to eq(false) }
      it { expect(subject.send(:has_permission?, 'index')).to eq(false) }
    end
  end
end

RSpec.shared_examples 'enforces the read permission' do |klass, module_name|
  let(:master_class) { klass.new }
  subject { described_class.new(Person.new, master_class) }
  context 'logged in admin with read permission' do
    permission_list = {
      index: true,
      show: true,
      create: false,
      new: false,
      update: false,
      edit: false,
      destroy: false,
      export: false,
      history: false,
      show_in_app: false,
      select_product: false
    }

    describe 'permissions' do
      before :each do
        allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new("#{module_name}_read": true))
      end
      permission_list.each do |policy, value|
        if value
          it { is_expected.to permit_action(policy) }
        else
          it { is_expected.to forbid_action(policy) }
        end
      end
    end
    describe 'protected methods' do
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, 'bogous')).to eq(false) }
      it { expect(subject.send(:has_permission?, 'index')).to eq(false) }
    end
  end
end

RSpec.shared_examples 'enforces the update permission' do |klass, module_name|

  let(:master_class) { klass.new }
  subject { described_class.new(Person.new, master_class) }
  context 'logged in admin with update permission' do
    permission_list = {
      index: false,
      show: false,
      create: true,
      new: true,
      update: true,
      edit: true,
      destroy: false,
      export: false,
      history: false,
      show_in_app: false,
      select_product: false
    }

    describe 'permissions' do
      before :each do
        allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new("#{module_name}_update": true))
      end
      permission_list.each do |policy, value|
        if value
          it { is_expected.to permit_action(policy) }
        else
          it { is_expected.to forbid_action(policy) }
        end
      end
    end
    describe 'protected methods' do
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, 'bogous')).to eq(false) }
      it { expect(subject.send(:has_permission?, 'index')).to eq(false) }
    end
  end
end

RSpec.shared_examples 'enforces the delete permission' do |klass, module_name|

  let(:master_class) { klass.new }
  subject { described_class.new(Person.new, master_class) }
  context 'logged in admin with delete permission' do
    permission_list = {
      index: false,
      show: false,
      create: false,
      new: false,
      update: false,
      edit: false,
      destroy: true,
      export: false,
      history: false,
      show_in_app: false,
      select_product: false
    }

    describe 'permissions' do
      before :each do
        allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new("#{module_name}_delete": true))
      end
      permission_list.each do |policy, value|
        if value
          it { is_expected.to permit_action(policy) }
        else
          it { is_expected.to forbid_action(policy) }
        end
      end
    end
    describe 'protected methods' do
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, 'bogous')).to eq(false) }
      it { expect(subject.send(:has_permission?, 'index')).to eq(false) }
    end
  end
end

